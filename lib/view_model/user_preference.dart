import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pratical_task/model/user_date.dart';
import 'package:pratical_task/view/home_page.dart';
import 'package:pratical_task/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUserToken(UserData response) async {
    var token = response.apiToken;
    print(token);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', response.apiToken ?? "");
    prefs.setBool('isLogin', response.isLoggedIn ?? true);

    return true;
  }

  Future<UserData> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool? isLogin = prefs.getBool('isLogin');

    return UserData(apiToken: token ?? "", isLoggedIn: isLogin);
  }

  Future<void> checkAuthStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Get.to(HomePage());
    } else {
      Get.to(LoginScreen());
    }
  }

  Future<void> saveUser(UserData user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString('userData', userJson); 
  }

  Future<UserData?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('userData');
    if (userJson != null) {
      return UserData.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData'); 
  }
}
