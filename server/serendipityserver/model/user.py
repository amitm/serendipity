import datetime
import math

from sqlalchemy import orm, Column, Unicode, Integer, Float
import facebook

from serendipityserver.model.meta import Session, Base
from serendipityserver.lib.helpers import airship

class User(Base):
    __tablename__ = 'users'
    facebook_user_id = Column(Integer, primary_key=True)
    access_token = Column(Unicode(255))
    device_token = Column(Unicode(255))
    lat = Column(Float)
    lon = Column(Float)
    
    def __init__(self, facebook_user_id, access_token, device_token):
        self.access_token = access_token
        self.facebook_user_id = facebook_user_id
        self.device_token = device_token
    
    def __unicode__(self):
        return str(self.facebook_user_id) + ":" +\
               self.access_token + ":" + self.device_token
               
    def friend_checkins(self, seconds=300):
        graph_api = facebook.GraphAPI(self.access_token)
        friend_ids = set()
        for friend in graph_api.get_connections("me", "friends")["data"]:
            friend_ids.add(friend["id"])
        
        checkins = graph_api.request("search", {"type" : "checkin"})["data"]
        parsed_checkins = []
        now = datetime.datetime.utcnow()
        for checkin in checkins:
            place = checkin["place"]
            checkin_time =\
                datetime.datetime.strptime(checkin["created_time"],
                                           "%Y-%m-%dT%H:%M:%S+0000")
            delta = now - checkin_time
            if delta.days > 0 or delta.seconds > seconds:
                continue
            friends_here = set()
            if checkin["from"]["id"] in friend_ids:
                friends_here.add((checkin["from"]["name"], 
                                  checkin["from"]["id"]))
            try:
                for tag in checkin["tags"]["data"]:
                    if tag["id"] in friend_ids:
                        friends_here.add((tag["name"], 
                                          tag["id"]))
            except KeyError:
                pass
            if friends_here:
                lat = float(place["location"]["latitude"])
                lon = float(place["location"]["longitude"])
                place["distance"] = distance(self.lat, self.lon, lat, lon)
                parsed_checkins.append({"place" : place, 
                                        "friends" : friends_here})
        return parsed_checkins

    def send_nearby_notification(self, checkin):
        friends = list(checkin["friends"])
        alert = friends[0][0]
        for i in xrange(1, len(friends)):
            alert += ", " + friends[i][0]
        
        alert += " checked into " + checkin["place"]["name"]
        alert += ". It's only " + str(checkin["place"]["distance"]) + " km from you."
        push_server = airship()
        push_server.push({'aps': {'alert': alert}}, 
                         device_tokens=[self.device_token])        

    __str__ = __unicode__

def user_with_access_token(access_token, device_token):
    graph_api = facebook.GraphAPI(access_token)
    me = graph_api.get_object("me")
    # TODO wrap in a try catch
    facebook_user_id = facebook_user_id = me['id']
    query = Session.query(User)
    user = query.filter_by(facebook_user_id=facebook_user_id).first()
    if user is None:
        user = User(facebook_user_id, access_token, device_token)
        push_client = airship()
        push_client.register(device_token, alias='fbuid:' + str(facebook_user_id))
        Session.add(user)
        Session.commit()
    elif (user.access_token is not access_token or 
          user.device_token is not device_token):
        user.access_token = access_token
        user.device_token = device_token
        push_client = airship()
        push_client.register(device_token, alias='fbuid:' +\
                             str(user.facebook_user_id))
        Session.commit()
    return user

def update_location(access_token, latitude, longitude):
    query = Session.query(User)
    user = query.filter_by(access_token=access_token).first()
    if user:
        user.lat = latitude
        user.lon = longitude
        Session.commit()
    return True

def distance(lat1, lon1, lat2, lon2):    
    r = 6371
    lat_delta = math.radians((lat2 - lat1))
    lon_delta = math.radians((lon2 - lon1))
    a = math.pow(math.sin(lat_delta / 2), 2) +\
        math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) *\
        math.pow(math.sin(lon_delta / 2), 2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    d = r * c
    return d
