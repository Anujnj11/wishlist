// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wishlisttracker/models/searchBarUrl.dart';

// class ProductUrlDialog extends StatefulWidget {
//   @override
//   ProductUrlDialogState createState() => ProductUrlDialogState();
// }

// class ProductUrlDialogState extends State<ProductUrlDialog> {
//   final _searchURL = new TextEditingController();
//   Timer _debounce;
//   RangeValues values = RangeValues(1, 100);
//   RangeLabels labels = RangeLabels('1', '100');
//   bool setPrice = false;
//   SearchBarURL searchBarD;
//   @override
//   void initState() {
//     super.initState();
//     // setInitState();
//   }

//   setInitState() {
//     _searchURL.addListener(_onSearchChanged);
//   }

//   _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce.cancel();
//     _debounce = Timer(const Duration(milliseconds: 2000), () {
//       var urlPattern =
//           r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
//       bool isValidUrl = new RegExp(urlPattern, caseSensitive: false)
//           .hasMatch(_searchURL.text);
//       print(isValidUrl);
//       if (isValidUrl) {
//         getProductInfo(_searchURL.text);
//       }
//     });
//   }

//   getProductInfo(searchURL) {
//     Provider.of<SearchBarURL>(context, listen: false).getProductInfo(searchURL);
//   }

//   @override
//   void dispose() {
//     _searchURL.removeListener(_onSearchChanged);
//     _searchURL.dispose();
//     super.dispose();
//   }

//   changeRange(SearchBarURL searchBarD) {
//     setPrice = true;
//     double minPrice = 0.3 * int.parse(searchBarD.price);
//     double basePrice = double.parse(searchBarD.price);
//     values = RangeValues(minPrice, basePrice);
//     labels =
//         RangeLabels(minPrice.toInt().toString(), basePrice.toInt().toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     // searchBarD =
//     //     Provider.of<SearchBarURL>(context, listen: false).getSearchedUrl();
//     // if (searchBarD != null && searchBarD.price != null && !setPrice)
//     //   changeRange(searchBarD);

//     return Container(
//       width: MediaQuery.of(context).size.width * 0.95,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Row(
//                 textDirection: TextDirection.ltr,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Provider.of<SearchBarURL>(context).isSearching
//                       ? CircularProgressIndicator(
//                           backgroundColor: Color(4281320352), strokeWidth: 2.0)
//                       : ButtonTheme(
//                           height: 40.0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           child: RaisedButton(
//                             color: Theme.of(context).accentColor,
//                             textColor: Colors.white,
//                             onPressed: () {},
//                             child: Text("Save"),
//                           ),
//                         )

//                   // ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   // Padding(
//                   //   padding: EdgeInsets.all(5.0),
//                   //   child: TextField(
//                   //     // onEditingComplete: ,
//                   //     controller: _searchURL,
//                   //     autofocus: true,
//                   //     style: TextStyle(height: 0.9),
//                   //     decoration: InputDecoration(
//                   //       labelText: "Paste URL",
//                   //       fillColor: Colors.white,
//                   //       border: OutlineInputBorder(
//                   //         borderRadius: BorderRadius.circular(10.0),
//                   //         borderSide: BorderSide(),
//                   //       ),
//                   //     ),
//                   //     keyboardType: TextInputType.url,
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: TextField(
//                       readOnly: searchBarD?.productName != null ? false : true,
//                       controller:
//                           TextEditingController(text: searchBarD?.productName),
//                       style: TextStyle(height: 0.9),
//                       decoration: InputDecoration(
//                         labelText: "Product Name",
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: TextField(
//                       readOnly: searchBarD?.price != null ? true : false,
//                       controller:
//                           TextEditingController(text: searchBarD?.price),
//                       style: TextStyle(height: 0.9),
//                       decoration: InputDecoration(
//                         labelText: "Product Price",
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(),
//                         ),
//                         //fillColor: Colors.green
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text("Expected Price"),
//                         RangeSlider(
//                           min: searchBarD?.price != null
//                               ? (0.3 * int.parse(searchBarD.price))
//                               : 1,
//                           max: searchBarD?.price != null
//                               ? (double.parse(searchBarD.price))
//                               : 100,
//                           values: values,
//                           divisions: 10,
//                           labels: labels,
//                           activeColor: Color(4281320352),
//                           onChanged: (value) {
//                             setState(() {
//                               print(value);
//                               values = value;
//                               labels = RangeLabels(
//                                   '₹${value.start.toInt().toString()}',
//                                   '₹${value.end.toInt().toString()}');
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
