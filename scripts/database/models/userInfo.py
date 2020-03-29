
from datetime import datetime
from .db import db


class userInfo(db.Document):
    deviceId = db.StringField(unique=True)
    firebaseId = db.StringField()
    userName = db.StringField()
    emailId = db.StringField()
    phone = db.StringField()
    profilePic = db.StringField()
    IP = db.StringField()
    createdAt = db.DateTimeField(default=datetime.now())
