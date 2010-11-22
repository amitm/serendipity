import logging

from pylons import request, response, session, tmpl_context as c, url
from pylons.controllers.util import abort, redirect

from serendipityserver.lib.base import BaseController, render
from serendipityserver.model.user import User
import serendipityserver.model.user as user

log = logging.getLogger(__name__)

class MainController(BaseController):

    def index(self):
        print request
        # Return a rendered template
        #return render('/main.mako')
        # or, return a string
        return 'Hello World'

    def register_device(self):
        access_token = request.params['access_token']
        device_token = request.params['device_token']
        current_user = user.user_with_access_token(access_token, device_token)
        print request.params
        return "1"
        
    def update_location(self):
        user.update_location(request.params['access_token'], 
                             request.params['latitude'],
                             request.params['longitude'])
        return "1"


