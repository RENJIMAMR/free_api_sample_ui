import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static Future<String> getStoredAccessToken() async {
    //shared preffs object
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //get stored access token
    String storedToken = prefs.getString("access") ?? "";
    return storedToken;
  }
}
