import 'dart:async';

import 'package:firstproject/coinmarketcap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CryptoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CryptoPageState();
  }
}

class CryptoPageState extends State<CryptoPage> with SingleTickerProviderStateMixin {

  var backgroundColor = Colors.blue;

  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        backgroundColor = Colors.blue;
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      Timer.periodic(Duration(seconds: 2), (timer) {
        setState(() {
          backgroundColor = Colors.red;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Market args = ModalRoute.of(context)!.settings.arguments as Market;

    return Scaffold(
      appBar: AppBar(title: Text(args.name)),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
            color: backgroundColor
        ),
        child: Center(
          child: ElevatedButton(
              child: Text("Play"), onPressed: () {
            setState(() {
              backgroundColor = Colors.green;
            });
          }
          ),
        ),
      ),
    );
  }

}