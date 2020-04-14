import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/userInfo.dart';
import './apiCalling.dart';
import 'localNotification.dart';

class DeviceInfo {
  DeviceInfo._();

  factory DeviceInfo() => _instance;

  static final DeviceInfo _instance = DeviceInfo._();

  bool _initialized = false;

  PushNotificationsManager pnObj = new PushNotificationsManager();
  PackageInfo packageInfo;
  String deviceId;
  String userAppVersion;

  Future<void> init(context) async {
    if (!_initialized) {
      deviceId = await DeviceId.getID;
      _initialized = true;
      print("Device id $deviceId");
      getFireBaseId(context);
    }
  }

  Future<String> getDeviceId() async {
    return await DeviceId.getID;
  }

  getFireBaseId(context) async {
    String firebaseId = await pnObj.init();
    String getAV = await getAppVersion();
    saveDeviceInfo(context, firebaseId, getAV);
  }

  saveDeviceInfo(context, firebaseId, getAV) {
    Provider.of<UserInfo>(context, listen: false)
        .setUserInfo(deviceId, firebaseId, getAV);
  }

  getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    userAppVersion =  packageInfo.version;
    return userAppVersion;
  }

  getUserVersion(){
    return userAppVersion;
  }
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final LocalNotification objLocal = new LocalNotification();

  bool _initialized = false;
  String firebaseToken;

  Future<String> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      firebaseToken = await _firebaseMessaging.getToken();
      _initialized = true;
      print("FirebaseMessaging token: $firebaseToken");
    }
    getMessage();
    return firebaseToken;
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      objLocal.init();
      String title = message["notification"]["title"];
      String body = message["notification"]["body"];
      objLocal.notification(title, body);
      print('on message $message');
      // print(message);
    }, onResume: (Map<String, dynamic> message) async {
      objLocal.init();
      String title = message["notification"]["title"];
      String body = message["notification"]["body"];
      objLocal.notification(title, body);
      print('on resume $message');
      // print(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      objLocal.init();
      String title = message["notification"]["title"];
      String body = message["notification"]["body"];
      objLocal.notification(title, body);
      print('on launch $message');
      // print(message);
    });
  }
}
