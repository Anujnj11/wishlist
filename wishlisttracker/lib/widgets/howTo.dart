import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wishlisttracker/screen/howToInfo.dart';

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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HowToInfo()));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(
                FontAwesomeIcons.question,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
        ));
  }
}
