import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/userInfo.dart';
// import 'package:wishlisttracker/screen/howToInfo.dart';

class HowTo extends StatefulWidget {
  @override
  _HowToState createState() => _HowToState();
}

class _HowToState extends State<HowTo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 5.0,
          left: 5,
        ),
        child: Container(
          height: 42.0,
          width: 42.0,
          child: GestureDetector(
            onTap: () {
              Provider.of<UserInfo>(context, listen: false).showHow(true);
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/qu.png'),
                )
                // Icon(
                // FontAwesomeIcons.question,
                // color: Colors.white,
                // size: 18.0,
                // ),
                ),
          ),
        ));
  }
}
