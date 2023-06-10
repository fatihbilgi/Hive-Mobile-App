import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:localstorage/localstorage.dart';

import '../../Core/Request.dart';


enum LoginState{
  LoadingState,
  LoadedState

}




class LoginController extends GetxController {
  final LocalStorage storage = new LocalStorage('app');

 late LoginState _loginState;


  LoginState get loginState => _loginState;

  set loginState(LoginState value) {
    _loginState = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showpassword = true;
    loginState = LoginState.LoadedState;
  }

  late bool _showPassword;
  bool get showpassword => _showPassword;
  set showpassword(bool value) {
    _showPassword = value;
    update();
  }




  void apiLogin(String organization , String email , String password) async {

    loginState = LoginState.LoadingState;
    Request request = Request(
        url: "api/account/token",
        body: jsonEncode({
          "organization":organization,
          "email":email,
          "password":password
        }));

    request.post("").then((value) async {
      var json = jsonDecode(value);
      if (json['generated'] == true) {
        loginState = LoginState.LoadedState;

        Get.snackbar("Success", json['message'],
            colorText: Colors.white,
            icon: Icon(
              Icons.assignment_turned_in_sharp,
              color: Colors.white,
            ),
            backgroundColor: Colors.green);
        await storage.setItem("token", json['token']);
        await storage.setItem("email", email);

        Get.toNamed("/HOME");
      } else {
        loginState = LoginState.LoadedState;

        Get.snackbar("Error", json['message'],
            colorText: Colors.white,
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            backgroundColor: Colors.red);
      }
    }).catchError((onError) {
      loginState = LoginState.LoadedState;

      Get.snackbar("Error", onError,
          colorText: Colors.white,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          backgroundColor: Colors.red);
      print(onError);
      //loading(false);
    });
  }
}
