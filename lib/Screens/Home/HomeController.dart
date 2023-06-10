import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:hive/Models/HomeModel.dart';

import '../../Core/Request.dart';



enum HomeState{
  LoadingState,
  LoadedState,
  ErrorState
}


class HomeController extends GetxController{
  late HomeState _state;
  late HomeModel _response;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetSesions();
  }


  final LocalStorage storage = new LocalStorage('app');

  HomeState get state => _state;
  set state(HomeState value) {
    _state = value;
    update();
  }

  HomeModel get response => _response;

  set response(HomeModel value) {
    _response = value;
    update();
  }






  Future<void> GetSesions() async {

    state = HomeState.LoadingState;

    String token =  "Bearer "+await storage.getItem("token");

    String email =  await storage.getItem("email");

    String url = "api/session/session/get/"+email+"/sessions";

    Request request = Request(url: url);
    await request.get(token).then((value) async{
      var json = jsonDecode(value);
      if(json['success']==true){
        HomeModel model = HomeModel.fromJson(json);
        response = model;
        state = HomeState.LoadedState;
      }else{
        Get.snackbar("Error", json['message'],colorText: Colors.red,icon: Icon(Icons.error_outline,color: Colors.red,));
        state = HomeState.ErrorState;

      }
    }).catchError((onError) {
      debugPrint(onError);
      Get.snackbar("Error", "please try again later",colorText: Colors.red,icon: Icon(Icons.error_outline,color: Colors.red,));
      print(onError);
      state = HomeState.ErrorState;

    });
  }






}