import 'package:flutter/material.dart';

class HowToInfo extends StatefulWidget {
  @override
  _HowToInfoState createState() => _HowToInfoState();
}

class _HowToInfoState extends State<HowToInfo> {
  List<dynamic> shareApp;
  List<dynamic> withoutApp;
  _setShareApp() {
    shareApp = new List<dynamic>();
    shareApp.add({
      "no": "1",
      "title": "Open Shopping app",
      "imgSrc": "assets/productShare.png",
    });
    shareApp.add({
      "no": "2",
      "title": "Share with Pri⚡ce app",
      "imgSrc": "assets/productShareWIthAPP.png",
    });
  }

  _setWithoutApp() {
    withoutApp = new List<dynamic>();
    withoutApp.add({
      "no": "1",
      "title": "Open Browser, copy link",
      "imgSrc": "assets/productShare.png",
    });
    withoutApp.add({
      "no": "2",
      "title": "Share with Pri⚡ce app",
      "imgSrc": "assets/productShareWIthAPP.png",
    });
  }

  Widget getWithApp() {
    _setShareApp();
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        height: 750,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            Text(
              "With Product App",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 22.0),
            ),
            for (dynamic sharea in shareApp)
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                sharea["no"],
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            sharea["title"],
                            style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          sharea["imgSrc"],
                          // "assets/productShare.png",
                          height: 275.0,
                        ),
                      )
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget getWithoutApp() {
    _setWithoutApp();
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Container(
        height: 710,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            // shareApp.
            for (dynamic sharea in shareApp)
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                sharea["no"],
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            sharea["title"],
                            style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          sharea["imgSrc"],
                          // "assets/productShare.png",
                          height: 275.0,
                        ),
                      )
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          getWithApp(),
          getWithoutApp(),
        ],
      ),
    );
  }
}
