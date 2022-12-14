import 'dart:async';

import 'package:firstproject/coinmarketcap.dart';
import 'package:firstproject/database/favorites.dart';
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
  var formKey = GlobalKey<FormState>();
  var priceInput = TextEditingController();
  var coinInput = TextEditingController();
  var favorites = Favorites();
  var isInFavorites = false;

  void initState() {
    favorites.connect().then((value) {
      favorites.getFavorites().then((value) {
        print(value);
        Market args = ModalRoute.of(context)!.settings.arguments as Market;
        for (var m in value) {
          if (m.name == args.name) {
            setState(() {
              isInFavorites = true;
            });
            break;
          }
        }
      });
    });
    // Timer.periodic(Duration(seconds: 2), (timer) {
    //   setState(() {
    //     backgroundColor = Colors.blue;
    //   });
    // });
    // Future.delayed(Duration(seconds: 1), () {
    //   Timer.periodic(Duration(seconds: 2), (timer) {
    //     setState(() {
    //       backgroundColor = Colors.red;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Market args = ModalRoute.of(context)!.settings.arguments as Market;

    return Scaffold(
      appBar: AppBar(
          title: Text(args.name),
        actions: [
          IconButton(onPressed: () {
            if (isInFavorites) {
              favorites.removeFromFavorites(args);
              setState(() {
                isInFavorites = false;
              });
            } else {
              favorites.addToFavorites(args);
              setState(() {
                isInFavorites = true;
              });
            }
          }, icon: Icon(isInFavorites ? Icons.star : Icons.star_outline))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: priceInput,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Price USD"),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: coinInput,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Price ${args.name}"),
                      border: OutlineInputBorder()
                  ),
                ),
                Row(
                  children: [
                    Expanded(child:
                      ElevatedButton(onPressed: () {
                        if(formKey.currentState!.validate()) {
                          coinInput.text = (int.parse(priceInput.text) * args.price).toString();
                        }
                      },
                          child: Text("Convert")
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

}