import 'package:device_id/device_id.dart';

class DeviceInfo {
  DeviceInfo._();

  factory DeviceInfo() => _instance;

  static final DeviceInfo _instance = DeviceInfo._();

  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      String deviceId = await DeviceId.getID;
      _initialized = true;
      print("Device id $deviceId");
    }
  }
}
