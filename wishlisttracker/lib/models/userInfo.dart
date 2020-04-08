import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class UserInfo extends ChangeNotifier {
  UserInfo objUserInfo;
  bool _showHow = false;

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

  UserInfo get getUserInfo => objUserInfo;

  bool get getshowHow => _showHow;

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
      objUserInfo = UserInfo.fromJson(dynamicBody);
    } else {
      objUserInfo = new UserInfo();
    }
    notifyListeners();
  }

  void showHow(bool shouldShow) {
    _showHow = shouldShow;
    notifyListeners();
  }
}
