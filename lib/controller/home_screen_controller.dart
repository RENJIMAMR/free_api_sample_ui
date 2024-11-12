import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:token_test/model/product_model.dart';

class HomeScreenController with ChangeNotifier {
  //variable creation
  List<ProductModel>? productList = [];
  getProducts() async {
    final url = Uri.parse("https://freeapi.luminartechnohub.com/products-all/");

    try {
      //  // HTTP get request

      final response = await http.get(url, headers: {});
      if (response.statusCode == 200) {
        //convert data
        final decodedData = productResMOdelFromJson(response.body);
        productList = decodedData.data;
      }
    } catch (e) {}
  }
}
