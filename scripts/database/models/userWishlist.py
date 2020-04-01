
from datetime import datetime
from .db import db
from .exportModel import userInfo, masterWebsite
from mongoengine import *
from mongoengine import signals
import firebaseNotification


class userWishlist(db.Document):
    userInfo = db.ReferenceField(userInfo, required=True)
    masterWebsiteId = db.ReferenceField(masterWebsite)
    domainName = db.StringField()
    websiteUrl = db.URLField()
    currentPrice = db.StringField()
    currentRating = db.StringField()
    targetPrice = db.ListField(db.StringField())
    targetPriceInPer = db.StringField()
    validTillDate = db.DateTimeField(default=datetime.now())
    pushNotification = db.BooleanField()
    wishImages = db.ListField(db.URLField())
    notes = db.StringField()
    negativeReview = db.ListField(db.StringField())
    positiveReview = db.ListField(db.StringField())
    isActive = db.BooleanField()
    createdAt = db.DateTimeField(default=datetime.now())

    @classmethod
    def post_save(cls, sender, document, **kwargs):
        try:
            if 'created' in kwargs:
                if kwargs['created']:
                    print("Created")
                    firebaseId = document.userInfo.firebaseId
                    firebaseNotification.send_to_token(
                        firebaseId, "Done !", "Your wishlist has set")
                else:
                    print("Updated")
        except Exception as err:
            print(err)


signals.post_save.connect(userWishlist.post_save, sender=userWishlist)
