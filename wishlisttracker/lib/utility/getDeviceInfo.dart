import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './apiCalling.dart';

class DeviceInfo {
  DeviceInfo._();

  factory DeviceInfo() => _instance;

  static final DeviceInfo _instance = DeviceInfo._();

  bool _initialized = false;

  PushNotificationsManager pnObj = new PushNotificationsManager();
  String deviceId;
  Future<void> init() async {
    if (!_initialized) {
      deviceId = await DeviceId.getID;
      _initialized = true;
      print("Device id $deviceId");
      getFireBaseId();
    }
  }

  getFireBaseId() async {
    String firebaseId = await pnObj.init();
    pnObj.getMessage();
    saveDeviceInfo(firebaseId);
  }

  saveDeviceInfo(firebaseId) {
    var reqBody = {"deviceId": deviceId, "firebaseId": firebaseId};
    ApiCalling.postReq('userToken', reqBody);
  }
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
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
    return firebaseToken;
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      print(message);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      print(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      print(message);
    });
  }
}
