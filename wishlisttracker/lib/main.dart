import 'package:flutter/material.dart';
import 'package:wishlisttracker/screen/homescreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    super.initState();
    getMessage();
    _register();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      // setState(() => _message = message["notification"]["title"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      // setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      // setState(() => _message = message["notification"]["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WishList Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        // accentColor: Color(0xFFD8ECF1),
        accentColor: Color(4281215567),
        scaffoldBackgroundColor: Color(4294243574),

        // Use the old theme but apply the following three changes
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'BalooThambi2',
            bodyColor: Colors.black,
            displayColor: Colors.white),
        // scaffoldBackgroundColor: Color(4294769918),
      ),
      home: HomeScreen(),
    );
  }
}
