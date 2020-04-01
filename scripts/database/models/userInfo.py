
from datetime import datetime
from .db import db
from mongoengine import *
from mongoengine import signals
import firebaseNotification


class userInfo(db.Document):
    deviceId = db.StringField(unique=True)
    firebaseId = db.StringField()
    userName = db.StringField()
    emailId = db.StringField()
    phone = db.StringField()
    profilePic = db.StringField()
    IP = db.StringField()
    createdAt = db.DateTimeField(default=datetime.now())

    @classmethod
    def post_save(cls, sender, document, **kwargs):
        if 'created' in kwargs:
            if kwargs['created']:
                print("Created")
                firebaseId = document.firebaseId
                firebaseNotification.send_to_token(
                    firebaseId, "Hello !!", "Welcome to wishlist")
            else:
                print("Updated")


signals.post_save.connect(userInfo.post_save, sender=userInfo)
