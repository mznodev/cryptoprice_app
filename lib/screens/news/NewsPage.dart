import 'dart:convert';
import 'package:cryptoprice_app/classes/NewsClass.dart';
import 'package:cryptoprice_app/classes/WidgetsKeys.dart';
import 'package:cryptoprice_app/screens/news/NewsDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptoprice_app/services/services.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cryptoprice_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MyNewsPage extends StatefulWidget {
  @override
  _MyNewsPageState createState() => _MyNewsPageState();
}

var refreshNewsKey = new GlobalKey<RefreshIndicatorState>();



Random random = new Random();
int limit = random.nextInt(10);

class _MyNewsPageState extends State<MyNewsPage> {
  @override
  void initState() {
    super.initState();
    getCoinUSDtoEUR2().then((value) {
      setState(() {
        eur = value;
      });
    });
  }

  Future<NewsClass> LastestsNews = getLastestsNews();
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
        child: FutureBuilder<NewsClass>(
          future: LastestsNews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Results> news = snapshot.data.results;

              return RefreshIndicator(
                  key: new GlobalKey<RefreshIndicatorState>(),
                  onRefresh: refreshList,
                  child: ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Whatever sort of things you want to build
                        // with your Post object at yourPosts[index]:
                        return Card(
                          child:  new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  news[index].title??'No Data',
                                  style: Theme.of(context).textTheme.headline6,

                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyNewsDetailPage(dataNews: news[index])),
                                  );
                                   },
                              ),

                              new Text(
                                  news[index].description??'No Data',
                                  textAlign: TextAlign.end,
                                  ),


                            ],
                          ),
                        );
                        //return Text(coins[index].priceUsd.toString());
                      }));
            } else if (snapshot.hasError) {
              return Text("ERROR Snapshot:" + "${snapshot.error}");
            }

            // Por defecto, muestra un loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: MyDrawerWidget(),
    );
  }

  Future<void> refreshList() async {
    refreshNewsKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      LastestsNews = getLastestsNews();
    });
  }
}

convertMultiply(double precio, double valor) {
  //double x = 318191400000;
  //print(x*x); // Result: 1.0124576703396e+23
  return precio * valor;
}
