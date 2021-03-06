import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';
import 'package:wishlisttracker/utility/getDeviceInfo.dart';

class Wishlist extends ChangeNotifier {
  ValueNotifier<List<Wishlist>> wishListObj;

  String id;
  String userInfoId;
  String masterWebsiteId;
  String domainName;
  String websiteUrl;
  String name;
  String currentPrice;
  String scrapePrice;
  String currentRating;
  List<dynamic> targetPrice;
  String targetPriceInPer;
  int validTillDate;
  bool pushNotification;
  List<dynamic> wishImages;
  List<dynamic> notes;
  List<dynamic> negativeReview;
  List<dynamic> positiveReview;
  int perChange;
  bool isActive;

  Wishlist(
      {this.userInfoId,
      this.masterWebsiteId,
      this.domainName,
      this.websiteUrl,
      this.name,
      this.id,
      this.currentPrice,
      this.currentRating,
      this.targetPrice,
      this.targetPriceInPer,
      this.validTillDate,
      this.pushNotification,
      this.wishImages,
      this.notes,
      this.perChange,
      this.scrapePrice,
      this.negativeReview,
      this.isActive,
      this.positiveReview});

  List<Wishlist> get getWishList =>
      wishListObj != null ? wishListObj.value : [];

  Wishlist.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json["_id"]["\$oid"];
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
      scrapePrice = json["scrapePrice"];
      isActive = json["isActive"];

      double cp = double.parse(currentPrice);
      double sp = double.parse(scrapePrice);
      double temp = ((cp - sp) / cp) * 100;
      perChange = temp.toInt();
    }
  }

  List<Wishlist> wishListParser(dynamic responseBody) {
    // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return responseBody
        .map<Wishlist>((json) => Wishlist.fromJson(json))
        .toList();
  }

  void getWishlistProvider() async {
    String deviceId = await DeviceInfo().getDeviceId();
    print("deviceId inside product list " + deviceId);
    var reqBody = {"deviceId": deviceId};
    var dynamicBody = await ApiCalling.postReq('getProduct', reqBody);
    if (dynamicBody != null) {
      List<Wishlist> tempO = wishListParser(dynamicBody);
      wishListObj = new ValueNotifier<List<Wishlist>>(tempO);
    }
    if (wishListObj != null) {
      wishListObj.notifyListeners();
      notifyListeners();
    }
  }
}
