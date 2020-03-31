import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/dialogs/productUrlDialog.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/widgets/expandedSection.dart';
import 'package:wishlisttracker/widgets/profile.dart';
import 'package:wishlisttracker/widgets/searchBar.dart';

class HomeScreenHeader extends StatefulWidget {
  @override
  _HomeScreenHeaderState createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  bool fieldsUp = false;
  SearchBarURL searchBarD;
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels = RangeLabels('1', '100');
  bool showInfo = true;
  var _productName = new TextEditingController();
  var _productPrice = new TextEditingController();
  var _expectedPrice = new TextEditingController();

  changeRange(SearchBarURL searchBarD) {
    double minPrice = 0.3 * int.parse(searchBarD.price);
    double basePrice = double.parse(searchBarD.price);
    values = RangeValues(minPrice, basePrice);
    labels =
        RangeLabels(minPrice.toInt().toString(), basePrice.toInt().toString());
  }

  updateText(SearchBarURL searchBarD) {
    setState(() {
      fieldsUp = true;
    });
    _productName.text = searchBarD.productName;
    _productPrice.text = searchBarD.price;
    if (searchBarD.price != null && searchBarD.price != "")
      changeRange(searchBarD);
    else
      _expectedPrice.text = "100";
  }

  clearFields() {
    Provider.of<SearchBarURL>(context, listen: false).resetSearchedUrl();
    setState(() {
      fieldsUp = false;
      showInfo = true;
    });
    _productName.text = "";
    _productPrice.text = "";
    _expectedPrice.text = "";

    values = RangeValues(1, 100);
    labels = RangeLabels('1', '100');
  }

  @override
  Widget build(BuildContext context) {
    bool isSeaching = Provider.of<SearchBarURL>(context).isSearching;
    searchBarD =
        Provider.of<SearchBarURL>(context, listen: false).getSearchedUrl;
    if (searchBarD != null && !fieldsUp) updateText(searchBarD);
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
              // height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    // offset: Offset(0.0, 2.0),
                    // blurRadius: 0.5,
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
                    if (!fieldsUp)
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[SearchBar()],
                        ),
                      ),
                    if (isSeaching || fieldsUp)
                      ExpandedSection(
                          expand: showInfo,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.70,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    if (fieldsUp)
                                      Row(
                                        textDirection: TextDirection.ltr,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 5.0),
                                            child: ButtonTheme(
                                              height: 40.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: RaisedButton(
                                                color: Colors.white,
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  clearFields();
                                                },
                                                child: Text("Close"),
                                              ),
                                            ),
                                          ),
                                          ButtonTheme(
                                            height: 40.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: RaisedButton(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              textColor: Colors.white,
                                              onPressed: () {
                                                print(values.start);
                                                print(values.end);
                                                setState(() {
                                                  showInfo = false;
                                                });
                                              },
                                              child: Text("Save"),
                                            ),
                                          )
                                        ],
                                      ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: TextField(
                                            readOnly:
                                                searchBarD?.productName != null
                                                    ? false
                                                    : true,
                                            controller: _productName,
                                            // TextEditingController(
                                            //     text: searchBarD?.productName),
                                            style: TextStyle(
                                                height: 0.9,
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                              suffixIcon: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: searchBarD == null
                                                    ? CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                      )
                                                    : Text(""),
                                              ),
                                              labelText: "Product Name",
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: TextField(
                                            readOnly: searchBarD?.price != null
                                                ? true
                                                : false,
                                            controller: _productPrice,
                                            // TextEditingController(
                                            //     text: searchBarD?.price),
                                            style: TextStyle(
                                                height: 0.9,
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                              suffixIcon: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: searchBarD == null
                                                    ? CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                      )
                                                    : Text(""),
                                              ),
                                              labelText: "Product Price",
                                              fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(),
                                              ),
                                              //fillColor: Colors.green
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              if (searchBarD?.price == "")
                                                TextField(
                                                  controller: _expectedPrice,
                                                  style: TextStyle(
                                                      height: 0.9,
                                                      color: Colors.white),
                                                  decoration: InputDecoration(
                                                    labelText: "Expected Price",
                                                    fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(),
                                                    ),
                                                  ),
                                                ),
                                              if (searchBarD?.price != "" &&
                                                  searchBarD?.price != null)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Expected Price",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    RangeSlider(
                                                      min: searchBarD?.price !=
                                                              null
                                                          ? (0.3 *
                                                              int.parse(
                                                                  searchBarD
                                                                      .price))
                                                          : 1,
                                                      max: searchBarD?.price !=
                                                              null
                                                          ? (double.parse(
                                                              searchBarD.price))
                                                          : 100,
                                                      values: values,
                                                      divisions: 10,
                                                      labels: labels,
                                                      activeColor: Theme.of(
                                                              context)
                                                          .primaryColor, //Color(4281320352),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          print(value);
                                                          values = value;
                                                          labels = RangeLabels(
                                                              '₹${value.start.toInt().toString()}',
                                                              '₹${value.end.toInt().toString()}');
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
