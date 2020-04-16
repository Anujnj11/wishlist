
from datetime import datetime
from .db import db
from .exportModel import *
from mongoengine import *
from mongoengine import signals
from bson import json_util
from .firebaseNotify import *


class userWishlist(db.Document):
    userInfoId = db.ReferenceField(userInfo, required=True)
    masterWebsiteId = db.ReferenceField(masterWebsite)
    domainName = db.StringField()
    websiteUrl = db.URLField()
    name = db.StringField()
    scrapePrice = db.StringField()
    currentPrice = db.StringField()
    currentRating = db.StringField()
    targetPrice = db.ListField(db.StringField())
    targetPriceInPer = db.StringField()
    validTillDate = db.DateTimeField(default=datetime.now())
    pushNotification = db.BooleanField(default=True)
    wishImages = db.ListField(db.URLField())
    notes = db.StringField()
    negativeReview = db.ListField(db.StringField())
    positiveReview = db.ListField(db.StringField())
    isActive = db.BooleanField(default=True)
    createdAt = db.DateTimeField(default=datetime.now())

    @classmethod
    def post_save(cls, sender, document, **kwargs):
        try:
            if 'created' in kwargs:
                if kwargs['created']:
                    print("Created")
                    # firebaseId = document.userInfoId.firebaseId
                    userInfD = document["userInfoId"]
                    firebaseNotify().send_to_token(
                        userInfD, "Done !", "Your wishlist has set")
                else:
                    print("Updated")
        except Exception as err:
            print(err)

    # @classmethod
    # def to_json(self):
    #     data = self.to_mongo(self)
    #     return json_util.dumps(data)


signals.post_save.connect(userWishlist.post_save, sender=userWishlist)
