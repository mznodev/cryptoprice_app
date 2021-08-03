import 'package:cryptoprice_app/screens/authenticate/login.dart';
import 'package:cryptoprice_app/screens/home/HomePage.dart';
import 'package:cryptoprice_app/screens/news/NewsPage.dart';
import 'package:flutter/material.dart';

class MyCryptoPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage=new AssetImage('assets/cryptoprice.png');
    var image =new Image(image: assetsImage,width: 200.0,height: 200.0);
    return Container(child: image);
  }
}


class MyRippleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage=new AssetImage('assets/ripple.png');
    var image =new Image(image: assetsImage,height: 100.0);
    return Container(child: image);
  }
}

class MyStellarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage=new AssetImage('assets/stellar.png');
    var image =new Image(image: assetsImage,height: 100.0);
    return Container(child: image);
  }
}

class MyDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150.0,
            child: DrawerHeader(
              child: new MyCryptoPriceWidget(),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            title: new RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.home,
                        color: Colors.blue, size: 36.0),
                  ),
                  TextSpan(
                    text: " Home",
                    style: TextStyle(color: Colors.black, fontSize: 26.0),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage()),
              );
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
         /*  ListTile(
            title: new RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.show_chart,
                        color: Colors.green, size: 36.0),
                  ),
                  TextSpan(
                    text: " Charts",
                    style: TextStyle(color: Colors.black, fontSize: 26.0),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ), */
          ListTile(

            title: new RichText(

              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.article_outlined,
                        color: Colors.pink, size: 36),
                  ),
                  TextSpan(
                    text: " News",
                    style: TextStyle(color: Colors.black, fontSize: 26 ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyNewsPage()),
              );
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          /* ListTile(
            title: new RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.settings, size: 36),
                  ),
                  TextSpan(
                    text: " Settings",
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ), */
          ListTile(
            title: new RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.exit_to_app,
                      size: 36,
                      color: Colors.black54,
                    ),
                  ),
                  TextSpan(
                    text: " Logout",
                    style: TextStyle(color: Colors.black54, fontSize: 26),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login(),
              ));
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}