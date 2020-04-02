import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class Wishlist extends ChangeNotifier {
  List<Wishlist> wishListObj = [];

  String userInfoId;
  String masterWebsiteId;
  String domainName;
  String websiteUrl;
  String name;
  String currentPrice;
  String currentRating;
  List<dynamic> targetPrice;
  String targetPriceInPer;
  int validTillDate;
  String pushNotification;
  List<dynamic> wishImages;
  List<dynamic> notes;
  List<dynamic> negativeReview;
  List<dynamic> positiveReview;

  Wishlist(
      {this.userInfoId,
      this.masterWebsiteId,
      this.domainName,
      this.websiteUrl,
      this.name,
      this.currentPrice,
      this.currentRating,
      this.targetPrice,
      this.targetPriceInPer,
      this.validTillDate,
      this.pushNotification,
      this.wishImages,
      this.notes,
      this.negativeReview,
      this.positiveReview});

  List<Wishlist> get getWishList => wishListObj;

  Wishlist.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      userInfoId = json["_id"]["\$oid"];
      masterWebsiteId = json["userInfoId"]["\$oid"];
      domainName = json["masterWebsiteId"]["\$oid"];
      websiteUrl = json["websiteUrl"];
      name = json["name"];
      currentPrice = json["currentPrice"];
      currentRating = json["currentRating"];
      targetPrice = json["targetPrice"];
      targetPriceInPer = json["targetPriceInPer"];
      validTillDate = json["validTillDate"]["\$date"];
      pushNotification = json["pushNotification"];
      wishImages = json["wishImages"];
      notes = json["notes"];
      negativeReview = json["negativeReview"];
      positiveReview = json["positiveReview"];
    }
  }

  List<Wishlist> parsePhotos(dynamic responseBody) {
    // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return responseBody
        .map<Wishlist>((json) => Wishlist.fromJson(json))
        .toList();
  }

  void getWishlist(userInfoId) async {
    var reqBody = {"userInfoId": userInfoId};
    var dynamicBody = await ApiCalling.postReq('getProduct', reqBody);
    if (dynamicBody != null) {
      wishListObj = parsePhotos(dynamicBody);
    }

    notifyListeners();
  }
}
