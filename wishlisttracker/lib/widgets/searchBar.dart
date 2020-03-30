import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/dialogs/productUrlDialog.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  
  @override
  void initState() {
    super.initState();
    // _searchURL.addListener(_onSearchChanged);
  }



  @override
  Widget build(BuildContext context) {
    // SearchBarURL obj = Provider.of<SearchBarURL>(context).getData;
    // return Consumer<SearchBarURL>(builder: (context, searchBarObj, old) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: TextField(
                // onTap: () => ProductUrlDialogState().showDialogBox(context),
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          content: ProductUrlDialog());
                    }),
                // /Provider.of<SearchBarURL>(context, listen: false)
                // /    .showDialogStatus(),
                // controller: _searchURL,
                style: TextStyle(
                  fontSize: 18,
                ),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.link,
                      size: 30,
                    ),
                    border: InputBorder.none,
                    hintText: "Tap to add product URL",
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey)),
              ),
            )),
      ),
    );
  }
}
