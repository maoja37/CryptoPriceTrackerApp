// ignore_for_file: prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';


class CoinCard extends StatelessWidget {
  String name;
  String symbol;
  String imageUrl;
  double price;
  double change;
  double changePercentage;

  CoinCard({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 1)
        ], color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          spreadRadius: 1,
                          blurRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          spreadRadius: 1,
                          blurRadius: 1)
                    ],
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)),
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Text(
                    symbol,
                    style: TextStyle(color: Colors.grey[900], fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    price.toDouble().toString(),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    change < 0
                        ? '$change'
                        : '+$change',
                    style: TextStyle(
                      color: change < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    changePercentage < 0
                        ? '$changePercentage%'
                        : '+$changePercentage%',
                    style: TextStyle(
                      color: changePercentage < 0 ? Colors.red : Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
