import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      _firebaseMessaging
          .getToken()
          .then((token) => print("FirebaseMessaging token: $token"));

      _initialized = true;
    }
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
