import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pratical_task/Utils/api_url.dart';
import 'package:pratical_task/model/user_date.dart';
import 'package:pratical_task/view_model/user_preference.dart';

import '../view/home_page.dart';

class AuthViewModel extends GetxController {
  var isLoading = false.obs;
  String errorMessage = "";

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _gender = "".obs;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;

  String get gender => _gender.value;

  void setGender(String value) {
    _gender.value = value;
  }

  void login() async {
    isLoading.value = true;
    errorMessage = "";
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );
      final responseJson = jsonDecode(response.body);
      print("Outside :${responseJson["data"]}");

      if (response.statusCode == 200) {
        var token = responseJson["data"]['api_token'];
        print("Token: $token");
        await UserPreference()
            .saveUserToken(UserData.fromJson(responseJson["data"]));

        await UserPreference()
            .saveUser(UserData.fromJson(responseJson["data"]));
        print(responseJson["data"]);
        Get.to(HomePage());

        Get.snackbar("Success", responseJson["message"],
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", responseJson["message"] ?? "Something went wrong",
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage = e.toString();
    }
  }

  void signUp() async {
    if (gender.isEmpty) {
      setGender("male");
    }
    print(gender);
    print(
        "${firstNameController.text} ${lastNameController.text} ${emailController.text} ${passwordController.text},${passwordController.text}");
    isLoading.value = true;
    errorMessage = "";

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.registerUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "mobile": phoneNumberController.text,
          "gender": gender,
        }),
      );

      final responseJson = jsonDecode(response.body);

      if (response.statusCode == 200 && responseJson["status"] == true) {
        Get.snackbar(
            "Success",
            snackPosition: SnackPosition.TOP,
            responseJson["message"]);
        Get.snackbar("Success", responseJson["message"],
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", responseJson["message"] ?? "Something went wrong",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}


// {
//     "status": true,
//     "data": {
//         "id": 35,
//         "first_name": "Test",
//         "last_name": "User",
//         "username": null,
//         "email": "example@gmail.com",
//         "api_token": null,
//         "avatar": null,
//         "login_type": null
//     },
//     "message": "Register successfully"
// }