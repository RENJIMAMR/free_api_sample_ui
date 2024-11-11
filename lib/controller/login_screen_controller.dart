import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_test/model/login_model.dart';

class LoginScreenController with ChangeNotifier {
  bool isLoading = false;

  Future onLogin({required String email, required String password}) async {
    bool isLoading = true;
    notifyListeners();
    //url setup
    final url = Uri.parse("https://freeapi.luminartechnohub.com/login");
    try {
//call http method
      final response =
          await http.post(url, body: {"email": email, "password": password});
      //check status code
      if (response.statusCode == 200) {
        //convert data
        LoginResMOdel loginMOdel = loginResMOdelFromJson(response.body);
        //check whether access token is available or not
        if (loginMOdel.access! != null && loginMOdel.access!.isNotEmpty) {
          //shared preference objects to store acc and refresh
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("access", loginMOdel.access.toString());
          // log(prefs.getString("access").toString());
          prefs.setString("refresh", loginMOdel.refresh.toString());
        }

        //token store
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
