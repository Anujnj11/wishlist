import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class UserInfo extends ChangeNotifier {
  UserInfo _objUserInfo;

  String deviceId;
  String firebaseId;
  String id;

  UserInfo.initial()
      : deviceId = "",
        firebaseId = '',
        id = '';

  UserInfo({
    this.deviceId,
    this.firebaseId,
    this.id,
  });

  UserInfo get getUserInfo => _objUserInfo;

  UserInfo.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      deviceId = json['deviceId'];
      firebaseId = json['firebaseId'];
      id = json['id'];
    }
  }

  void setUserInfo(deviceId, firebaseId) async {
    var reqBody = {"deviceId": deviceId, "firebaseId": firebaseId};
    var dynamicBody = await ApiCalling.postReq('userToken', reqBody);
    if (dynamicBody != null) {
      _objUserInfo = UserInfo.fromJson(dynamicBody);
    } else {
      _objUserInfo = new UserInfo();
    }
  }
}
