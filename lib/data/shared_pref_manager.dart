import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefManager {
  final String USER_ID = "userId";
  final String USER_LAST_NAME = "userName";
  final String USER_EMAIL = "userEmail";

  setUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(USER_ID, userId);
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(USER_ID) ?? -1;
    return userId;
  }

  setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_LAST_NAME, userName);
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(USER_LAST_NAME) ?? "";
    return userName;
  }

  setUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_EMAIL, userEmail);
  }

  getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString(USER_EMAIL) ?? "";
    return userEmail;
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
}
