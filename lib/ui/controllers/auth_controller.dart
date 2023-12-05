import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mp/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? user;
  //Save User information in Cache memory
  static Future<void> saveUserInformation(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    token = t;
    user = model;
  }

  //update user information
  static Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    user = model;
  }

  // User informatio initialize
  static Future<void> intializeUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString('user') ?? '{}'));
  }

  //Auth status check
  static Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      await intializeUserCache();
      return true;
    }
    return false;
  }

  //clear auth data from sharepreference cache memory
  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }
}
