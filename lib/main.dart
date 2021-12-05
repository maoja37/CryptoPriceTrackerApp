// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:async';

import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:crypto_price_tracker_app/coin_card.dart';
import 'package:crypto_price_tracker_app/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(
      Uri.parse(
'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2C%20ethereum%2C%20solana%2C%20safemoon&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (var i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
      }
      
      
      setState(() {
        coinList;
      });

      return coinList;
    } else {
      throw Exception('failed to load coin');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Text('CRYPTOBASE',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 25,
                  fontWeight: FontWeight.w400)),
        ),
        body: 
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: coinList.length,
          itemBuilder: (context, index) {
            return CoinCard(
              name: coinList[index].name,
              symbol: coinList[index].symbol,
              imageUrl: coinList[index].imageUrl,
              price: coinList[index].price.toDouble(),
              change: coinList[index].change.toDouble(),
              changePercentage: coinList[index].changePercentage.toDouble(),
            );
          },
        )
        // ListView(
        //   scrollDirection: Axis.vertical,
        //   children: [
        //     CoinCard(
        //         name: 'Bitcoin',
        //         symbol: 'btc',
        //         imageUrl:
        //             "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        //         price: 49372,
        //         change: 906.1,
        //         changePercentage: 1.86956),
        //     CoinCard(
        //         name: 'ethereum',
        //         symbol: 'eth',
        //         imageUrl:
        //             "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
        //         price: 4165.79,
        //         change: 127.33,
        //         changePercentage: 3.15288),
        //   ],
        // ),
        );
  }
}
