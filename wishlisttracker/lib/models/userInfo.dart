import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';
import 'package:wishlisttracker/utility/getDeviceInfo.dart';

class UserInfo extends ChangeNotifier {
  UserInfo _objUserInfo;
  bool _showHow = false;

  String deviceId;
  String firebaseId;
  String id;
  String currentAppVersion;
  bool isMandatory;

  UserInfo.initial()
      : deviceId = "",
        firebaseId = '',
        currentAppVersion = "",
        id = '';

  UserInfo(
      {this.deviceId,
      this.firebaseId,
      this.id,
      this.currentAppVersion,
      this.isMandatory});

  UserInfo get getUserInfo => _objUserInfo;

  bool get getshowHow => _showHow;

  bool get isOutDatedVesion {
    bool isOutDated = false;
    if (_objUserInfo != null &&
        _objUserInfo.isMandatory != null &&
        _objUserInfo.isMandatory) {
      String userAppV = DeviceInfo().getUserVersion();
      isOutDated = userAppV != _objUserInfo.currentAppVersion;
    }
    return isOutDated;
  }

  UserInfo.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      deviceId = json['deviceId'];
      firebaseId = json['firebaseId'];
      id = json['id'];
      currentAppVersion = json['currentAppVersion'];
      isMandatory = json['isMandatory'] == 'true';
    }
  }

  void setUserInfo(deviceId, firebaseId, appVersion) async {
    var reqBody = {
      "deviceId": deviceId,
      "firebaseId": firebaseId,
      "appVersion": appVersion
    };
    var dynamicBody = await ApiCalling.postReq('userToken', reqBody);
    if (dynamicBody != null) {
      _objUserInfo = UserInfo.fromJson(dynamicBody);
    } else {
      _objUserInfo = new UserInfo();
    }
    notifyListeners();
  }

  void showHow(bool shouldShow) {
    _showHow = shouldShow;
    notifyListeners();
  }
}
