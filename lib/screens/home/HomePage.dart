import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptoprice_app/classes/ConverterUSDtoEURClass.dart';
import 'package:cryptoprice_app/classes/CryptoCoinsClass.dart';
import 'package:cryptoprice_app/screens/authenticate/login.dart';
import 'package:cryptoprice_app/services/services.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cryptoprice_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var refreshKey = GlobalKey<RefreshIndicatorState>();
Random random = new Random();
int limit = random.nextInt(10);

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getCoinUSDtoEUR2().then((value) {
      setState(() {
        eur = value;
      });
    });
  }

  Future<CryptoCoin> bitcoin = getCoins();
  var formatterPrice = NumberFormat.currency(locale: "es_ES", symbol: "€");
  var formatterDecimals = NumberFormat("###.00", "es_ES");
  var formaterPercentage =
      NumberFormat.decimalPercentPattern(locale: "es_ES", decimalDigits: 2);
  // Future<ConverterUSDtoEUR> converterEUR =getCoinUSDtoEUR();
  var eur;
  getCoinUSDtoEUR2() async {
    // https://free.currconv.com/api/v7/convert?q=USD_EUR&compact=ultra&apiKey=77f48852d6788c3f5aa3
    var queryParameters = {
      'q': 'USD_EUR',
      'compact': 'ultra',
      'apiKey': '77f48852d6788c3f5aa3'
    };
    final response = await http.get(
        Uri.https("free.currconv.com", "/api/v7/convert", queryParameters));

    if (response.statusCode == 200) {
      // Si la llamada al servidor fue exitosa, analiza el JSON
      print(json.decode(response.body));
      eur = json.decode(response.body);
      return eur['USD_EUR'].toString();
    } else {
      // Si la llamada no fue exitosa, lanza un error.
      throw Exception('Failed to load post');
    }
  }
  //var eur=converterEUR;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new MyCryptoPriceWidget(),
      ),
      body: Center(
        child: FutureBuilder<CryptoCoin>(
          future: bitcoin,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List coins = snapshot.data.data;
              return RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: ListView.builder(
                      itemCount: coins.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Whatever sort of things you want to build
                        // with your Post object at yourPosts[index]:
                        return Card(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  coins[index].id.toString(),
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),

                              new Text(
                                  double.parse(coins[index].changePercent24Hr)
                                          .toStringAsPrecision(2) +
                                      "%",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: double.parse(
                                                coins[index].changePercent24Hr)
                                            .isNegative
                                        ? Colors.red[600]
                                        : Colors.green[600],
                                  )),
                              new Center(
                                  child: eur == null
                                      ? new Text("No data")
                                      : new Text(
                                          formatterPrice
                                              .format(convertMultiply(
                                                  double.parse(
                                                      coins[index].priceUsd),
                                                  double.parse(eur)))
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4)),
                              //new Center(child: new Text("prueba")),
                              // new Text(new_data[index]["${index+1}"][1]['time']),
                            ],
                          ),
                        );
                        //return Text(coins[index].priceUsd.toString());
                      }));
            } else if (snapshot.hasError) {
              return Text("ERROR:" + "${snapshot.error}");
            }

            // Por defecto, muestra un loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
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
                      child: Icon(Icons.show_chart,
                          color: Colors.blue, size: 36.0),
                    ),
                    TextSpan(
                      text: " Graficos",
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
            ),
            ListTile(
              title: new RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.article_outlined,
                          color: Colors.pink, size: 36),
                    ),
                    TextSpan(
                      text: " Noticias",
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
            ),
            ListTile(
              title: new RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.settings, size: 36),
                    ),
                    TextSpan(
                      text: " Ajustes",
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
            ),
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
                      text: " Salir",
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
      ),
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      bitcoin = getCoins();
    });
  }
}

convertMultiply(double precio, double valor) {
  //double x = 318191400000;
  //print(x*x); // Result: 1.0124576703396e+23
  return precio * valor;
}
