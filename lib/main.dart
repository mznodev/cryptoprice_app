import 'package:cryptoprice_app/screens/home/HomePage.dart';
import 'package:cryptoprice_app/screens/news/NewsPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cryptoprice_app/screens/authenticate/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //MyApp({Key key, this.bitcoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      //themeMode: ThemeMode.dark,
      home: Login(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.

        '/homePage': (context) =>  MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/newsPage': (context) => MyNewsPage(),
      },
      darkTheme: ThemeData(brightness: Brightness.dark),

    );
  }
}
