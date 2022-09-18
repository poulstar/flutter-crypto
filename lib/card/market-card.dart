import 'package:firstproject/coinmarketcap.dart';
import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {

  final Market market;

  MarketCard({required this.market});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 12
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(market.name, textAlign: TextAlign.left),
              ),
              Text("USD: ${market.price}", textAlign: TextAlign.left)
            ],
          ),
        ),
      ),
    );
  }

}