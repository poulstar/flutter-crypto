import 'dart:convert';

import 'package:http/http.dart' as http;

class Shop {

  var baseUrl = "https://raingate.ir";
  var token = "";

  Future<List<Map<String, dynamic>>> getProducts() async {
    var response = await http.get(Uri.parse("$baseUrl/api/products?page[number]=1&page[size]=10"));
    var json = jsonDecode(response.body);
    List<Map<String, dynamic>> products = [];
    for (var product in json['data']['products']) {
      products.add({
        "name": product['name'],
        "cover": product['cover']?.get(0)['url']
      });
    }
    return products;
  }

  Future checkUser(String phone) async {
    var response = await http.post(Uri.parse("$baseUrl/api/login"), body: {
      "username": phone
    });
    var json = jsonDecode(response.body);
    if (json['data']['active']) {
      return true;
    } else {
      return false;
    }
  }

  Future login(String username, String password) async {
    var response = await http.post(Uri.parse("$baseUrl/oauth/token"), body: {
      "client_id": 2,
      "client_secret": "dXytYoKuHIpg8s200SL48e2toF1I4dokop87ZtkO",
      "grant_type": "password",
      "username": username,
      "password": password
    });
    var json = jsonDecode(response.body);
    token = json['access_token'];
  }

  Future getCart() async {
    http.get(Uri.parse("$baseUrl/api/cart"), headers: {
      "Authorization": "Bearer $token"
    });
  }

}