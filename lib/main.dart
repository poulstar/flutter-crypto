import 'dart:convert';
import 'package:firstproject/coinmarketcap.dart';
import 'package:firstproject/notification-page.dart';
import 'package:firstproject/pages/CryptoPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom-navigation.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '': (BuildContext context) => HomePage(),
        '/crypto': (BuildContext context) => CryptoPage(),
        '/notification': (BuildContext context) => NotificationPage()
      },
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  List<Market> markets = [];
  late var showMessage;

  HomePageState() {
    SharedPreferences.getInstance().then((pref) {
      var count = pref.getInt("appRunCount");
      if(count == null) {
        count = 0;
      }
      count += 1;
      pref.setInt("appRunCount", count);
      showMessage = SnackBar(content: Text("App opened $count time${count > 1 ? 's' : ''}"));
    });
  }

  @override
  void initState() {
    super.initState();
    var coinMarketCap = CoinMarketCap();

    coinMarketCap.getMarkets().then((value) {
      setState(() {
        markets = value;
      });
    });

    // var result = coinMarketCap.getMarkets();
    // result.then((value) {
    //   List<Market> temp = [];
    //   for (var entry in value) {
    //     temp.add(entry);
    //   }
    //   setState(() {
    //     markets = temp;
    //   });
    // }).onError((error, stackTrace) {
    //   print('Error: $error');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First project'),
        elevation: 12,
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(showMessage);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.black,
                  size: 24,
                )
            ),
          )
        ],
      ),
      body:
        Column(
          children: [
            Expanded(child: Container(
              child: ListView(children: [
                for (var market in markets)
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.network(market.logo, width: 64),
                                    Expanded(child:
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(market.name),
                                            Text(market.price.toStringAsFixed(3))
                                          ],
                                        ),
                                      )
                                    ),
                                    IconButton(onPressed: () {
                                      Navigator.of(context).pushNamed('/crypto',
                                        arguments: market
                                      );
                                    }, icon: Icon(Icons.keyboard_arrow_right))
                                  ],
                                ),
                              ])
                      ),
                      // child: MarketCard(market: market)
                    ),
              ]),
            )),
            BottomNavigation()
          ],
        )
    );
  }
}