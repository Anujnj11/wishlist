import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/models/userInfo.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchURL;
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    setInitState();
  }

  setInitState() {
    _searchURL = new TextEditingController();
    _searchURL.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      var urlPattern =
          r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
      bool isValidUrl = new RegExp(urlPattern, caseSensitive: false)
          .hasMatch(_searchURL.text);
      print(isValidUrl);
      if (isValidUrl) {
        String url = _searchURL.text;
        _searchURL.clear();
        getProductInfo(url);
      }
    });
  }

  getProductInfo(searchURL) {
    FocusScope.of(context).unfocus();
    Provider.of<SearchBarURL>(context, listen: false).getProductInfo(searchURL);
  }

  @override
  void dispose() {
    _searchURL.removeListener(_onSearchChanged);
    _searchURL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  Provider.of<UserInfo>(context, listen: false).showHow(false);
                },
                controller: _searchURL,
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
                    hintText: "Paste Product URL",
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey)),
              ),
            )),
      ),
    );
  }
}
