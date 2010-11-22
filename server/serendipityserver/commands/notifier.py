from paste.script.command import Command

from paste.deploy import appconfig
from pylons import config

from serendipityserver.config.environment import load_environment

conf = appconfig('config:development.ini', relative_to='.')
load_environment(conf.global_conf, conf.local_conf)

from serendipityserver.model.meta import Session, Base
from serendipityserver.model.user import User


class Notify(Command):
    # Parser configuration
    summary = "--NO SUMMARY--"
    usage = "--NO USAGE--"
    group_name = "myapp"
    parser = Command.standard_parser(verbose=False)

    def command(self):
        users = Session.query(User)
        for current_user in users:
            for checkin in current_user.friend_checkins(300):
                print checkin["place"]["distance"]
                if (checkin["place"]["distance"] < 5):
                    current_user.send_nearby_notification(checkin)

