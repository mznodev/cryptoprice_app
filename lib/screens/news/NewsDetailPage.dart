import 'package:cryptoprice_app/classes/NewsClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cryptoprice_app/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNewsDetailPage extends StatefulWidget {
  final Results dataNews;
  const MyNewsDetailPage({Key key, this.dataNews}) : super(key: key);
  @override
  _MyNewsDetailPageState createState() => _MyNewsDetailPageState();
}

var refreshNewsKey = new GlobalKey<RefreshIndicatorState>();

Random random = new Random();
int limit = random.nextInt(10);

class _MyNewsDetailPageState extends State<MyNewsDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new MyCryptoPriceWidget(),
      ),
      body: Center(
        child: Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: <Widget>[
              ListTile(
                title: Text(
                  widget.dataNews.title!=null?widget.dataNews.title:'No data',
                  style: Theme.of(context).textTheme.headline6,
                ),
                onTap: () {},
              ),
                   new Container(
    padding: EdgeInsets.all(20),
              child:  Image.network(widget.dataNews.imageUrl!=null?widget.dataNews.imageUrl:'No data')),

                       new Container(
    padding: EdgeInsets.all(20),
              child: new Text(
                widget.dataNews.description!=null?widget.dataNews.description:'No data',
                textAlign: TextAlign.left,
              )),
              
                       new Container(
    padding: EdgeInsets.all(20),
              child:  new RichText(
                textAlign: TextAlign.center,
                text: new TextSpan(
              children: [
              
                new TextSpan(
                  text: 'Open in Browser',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch(widget.dataNews.link??'');
                  },
                ),
              ],
            ))),
            ],
          ),
        ),
      ),
      drawer: MyDrawerWidget(),
    );
  }
}
