import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_test/model/product_model.dart';
import 'package:token_test/utils/app_utils.dart';

class HomeScreenController with ChangeNotifier {
  //variable creation for store products list from server
  List<ProductModel>? productList = [];
  bool isLoading = false;
  getProducts() async {
    //shared prefs object
    SharedPreferences prefs = await SharedPreferences.getInstance();
//get stored access token
    String storedToken = prefs.getString("access") ?? "";
    isLoading = true;
    //set up url
    final url = Uri.parse("https://freeapi.luminartechnohub.com/products-all/");

    try {
      //  // HTTP get request

      final response = await http.get(url, headers: {
        "Authorization": "Bearer ${await AppUtils.getStoredAccessToken()}",
      });
      log(response.body);
      //check status code
      if (response.statusCode == 200) {
        //convert data to model
        final decodedData = productResMOdelFromJson(response.body);
        //store data to variable because there were two maps
        productList = decodedData.data;
      }
    } catch (e) {}
  }
}
