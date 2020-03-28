import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: TextField(
                onChanged: (String txt) {},
                style: const TextStyle(
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
                ),
              ),
            )),
      ),
    );
  }
}
