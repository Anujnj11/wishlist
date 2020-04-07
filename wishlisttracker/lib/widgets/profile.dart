import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 15, right: 10),
        child: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/nerd.png'),
        ));
  }
}
