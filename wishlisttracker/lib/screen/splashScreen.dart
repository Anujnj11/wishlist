import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wishlisttracker/animation/fadeIn.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(children: <Widget>[
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("PRI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "BalooThambi2-ExtraBold",
                      letterSpacing: 1.2,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 75.0,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                Text("CE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "BalooThambi2-ExtraBold",
                      letterSpacing: 1.2,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 75.0,
                    )),
              ],
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.35,
          top: 10.0,
          bottom: 10.0,
          child: FadeIn(
            0.84,
            Icon(
              FontAwesomeIcons.bolt,
              color: Colors.yellow.shade500,
              size: 150.0,
            ),
          ),
        )
      ]),
    );
  }
}
