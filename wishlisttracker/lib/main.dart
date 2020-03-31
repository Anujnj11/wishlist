import 'package:flutter/material.dart';
// import 'package:wishlisttracker/screen/homescreen.dart';
import 'package:provider/provider.dart';
import './router.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchBarURL>(
          create: (_) => SearchBarURL(),
        )
      ],
      child: MaterialApp(
        title: 'Wishlist Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          // accentColor: Color(0xFFD8ECF1),
          accentColor: Colors.black,//Color(4281215567),
          scaffoldBackgroundColor: Color(4294440951),

          // Use the old theme but apply the following three changes
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'BalooThambi2',
              bodyColor: Colors.black,
              displayColor: Colors.white),
          // scaffoldBackgroundColor: Color(4294769918),
        ),
        // home: HomeScreen(),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
