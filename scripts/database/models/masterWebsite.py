from .db import db


class masterWebsite(db.Document):
    title = db.StringField()
    url = db.URLField()
    websiteName = db.StringField()
    domainName = db.StringField()
    priceClass = db.StringField()
    priceId = db.StringField()
    imagesClass = db.StringField()
    reviewClass = db.StringField()
    nameClass = db.StringField()
    nameId = db.StringField()
    ratingClass = db.StringField()
    brandColor = db.StringField()
    isActive = db.BooleanField(default=True)
