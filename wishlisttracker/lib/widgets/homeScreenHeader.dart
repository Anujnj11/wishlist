import 'package:flutter/material.dart';
import 'package:wishlisttracker/widgets/profile.dart';
import 'package:wishlisttracker/widgets/searchBar.dart';

class HomeScreenHeader extends StatefulWidget {
  @override
  _HomeScreenHeaderState createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: 160, //MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).accentColor,
                  offset: Offset(0.0, 2.0),
                  // blurRadius: 3.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Profile()],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[SearchBar()],
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
