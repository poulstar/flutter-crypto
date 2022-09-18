import 'dart:convert';

import 'package:http/http.dart' as http;

class CoinMarketCap {

  var address = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  var token = "bd6c49a4-2f94-4730-8583-f4a693ada941";


  Future<http.Response> getMarketsOld() {
    return http.get(Uri.parse(address),
        headers: {
          "X-CMC_PRO_API_KEY": token
        }
    );
  }

  Future<List<Market>> getMarkets() async {
    var result =  await http.get(Uri.parse(address), headers: {
        "X-CMC_PRO_API_KEY": token
      }
    );
    List<Market> markets = [];
    if(result.statusCode == 200) {
      var json = jsonDecode(result.body);
      for (var jsonMarket in json['data']) {
        var market = Market.fromJson(jsonMarket);
        markets.add(market);
      }
    }
    return markets;
  }




  Future<List<Market>> getMarketsModel() async {
    var result = await http.get(Uri.parse("$address/cryptocurrency/listings/latest"),
        headers: {
          "X-CMC_PRO_API_KEY": token
        }
    );
    List<Market> markets = [];
    if (result.statusCode == 200) {
      var json = jsonDecode(result.body);
      for (var marketJson in json['data']) {
        markets.add(Market.fromJson(marketJson));
      }
      return markets;
    } else {
      throw Exception('Failed to load market list');
    }
  }
}


class Market {

  final String name;
  final double price;
  final String logo;

  Market(this.name, this.price, this.logo);

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      json['name'],
      json['quote']['USD']['price'],
      "https://s2.coinmarketcap.com/static/img/coins/64x64/${json['id']}.png"
    );
  }
}