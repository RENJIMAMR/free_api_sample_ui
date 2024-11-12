import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_test/config/app_config.dart';
import 'package:token_test/model/login_model.dart';

class LoginScreenController with ChangeNotifier {
  bool isLoading = false;

  Future<bool> onLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final url = Uri.parse("${AppConfig.baseurl}/login");
    isLoading = true;
    notifyListeners();
    log("Login URL: $url");

    try {
      // HTTP POST request
      final response = await http.post(
        url,
        body: {"email": email, "password": password},
      );
      log("Response Status: ${response.statusCode}");
//check status code
      if (response.statusCode == 200) {
        // Parse response
        LoginResMOdel loginModel = loginResMOdelFromJson(response.body);
//check whether accsess token available or not
        if (loginModel.access != null && loginModel.access!.isNotEmpty) {
          // Store tokens in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("access", loginModel.access!);
          prefs.setString("refresh", loginModel.refresh!);

          isLoading = false;
          notifyListeners();
          return true; // Successful login
        }
      } else {
        var decoded = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(decoded["detail"])));
      }
    } catch (e) {
      log("Login error: $e");
    }

    // Reset loading state and notify listeners
    isLoading = false;
    notifyListeners();
    return false; // Login failed
  }
}
