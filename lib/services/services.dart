import 'dart:async';
import 'dart:convert';
import 'package:cryptoprice_app/classes/CryptoCoinsClass.dart';
import 'package:cryptoprice_app/classes/RatesEURClass.dart';
import 'package:http/http.dart' as http;
import '../classes/ConverterUSDtoEURClass.dart';

/* Future<Bitcoin> fetchPost() async {
  final response = await http
      .get(Uri.https("api.coindesk.com", "/v1/bpi/currentprice.json"));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print(json.decode(response.body));
    return Bitcoin.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

Future<Bitcoin> getEthereum() async {
  // https://api.coingecko.com/api/v3/coins/ethereum
  final response =
      await http.get(Uri.https("api.coingecko.com", "/api/v3/coins/ethereum"));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print(json.decode(response.body));
    return Bitcoin.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}
 */
/* Future getBitcoin() async {
  // https://api.coingecko.com/api/v3/coins/ethereum
  final response =
      await http.get(Uri.https("api.coingecko.com", "/api/v3/coins/bitcoin"));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print(json.decode(response.body));
    Map<String, dynamic> bitcoin = jsonDecode(response.body);
    return bitcoin;
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
} */

Future<CryptoCoin> getCoins() async {
  // https://api.coincap.io/v2/assets
  final response = await http.get(Uri.https("api.coincap.io", "v2/assets"));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print(json.decode(response.body));
    return CryptoCoin.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

Future<ConverterUSDtoEUR> getCoinUSDtoEUR() async {
  // https://free.currconv.com/api/v7/convert?q=USD_EUR&compact=ultra&apiKey=77f48852d6788c3f5aa3
  var queryParameters = {
    'q': 'USD_EUR',
    'compact': 'ultra',
    'apiKey': '77f48852d6788c3f5aa3'
  };
  final response = await http
      .get(Uri.https("free.currconv.com", "/api/v7/convert", queryParameters));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print(json.decode(response.body));
    return ConverterUSDtoEUR.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

Future<RatesEURClass> getCoinUSDtoEUR2() async {
  // https://free.currconv.com/api/v7/convert?q=USD_EUR&compact=ultra&apiKey=77f48852d6788c3f5aa3
  var queryParameters = {
    'q': 'USD_EUR',
    'compact': 'ultra',
    'apiKey': '77f48852d6788c3f5aa3'
  };
  final response =
      await http.get(Uri.https("api.coincap.io", "/v2/rates/euro"));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print(json.decode(response.body));
    return RatesEURClass.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

// getCoinUSDtoEUR2() async {
//   // https://free.currconv.com/api/v7/convert?q=USD_EUR&compact=ultra&apiKey=77f48852d6788c3f5aa3
//   var queryParameters = {
//     'q': 'USD_EUR',
//     'compact': 'ultra',
//     'apiKey': '77f48852d6788c3f5aa3'
//   };
//   final response =
//   await http.get(Uri.https("free.currconv.com","/api/v7/convert",queryParameters));
//
//   if (response.statusCode == 200) {
//     // Si la llamada al servidor fue exitosa, analiza el JSON
//     print(json.decode(response.body));
//
//     return ConverterUSDtoEUR.fromJson(json.decode(response.body)).uSDEUR;
//
//   } else {
//     // Si la llamada no fue exitosa, lanza un error.
//     throw Exception('Failed to load post');
//   }
// }
