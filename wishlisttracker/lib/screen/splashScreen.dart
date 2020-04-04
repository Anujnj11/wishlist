import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/screen/homescreen.dart';
import 'package:wishlisttracker/utility/getDeviceInfo.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DeviceInfo diObj = new DeviceInfo();

  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      _navigateToHome();
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _setOtherUtility(context);
    });
  }

  void _setOtherUtility(context) {
    diObj.init(context);
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(seconds: 5), () {});
    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("PRICE ⚡",
              style: TextStyle(
                fontFamily: "BalooThambi2-ExtraBold",
                color: Theme.of(context).primaryColor,
                fontSize: 45.0,
              ))
        ],
      ),
    );
  }
}
