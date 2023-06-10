import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import '../../Core/Request.dart';
import '../../Models/AnswerModel.dart';
import '../../Models/Markfeedbacktempmodel.dart';
import '../../Models/QuestionModel.dart';
import '../../Models/feedbackmodel.dart';



enum SesionDetailState{
  LoadingState,
  LoadedState,
  ErrorState,
  SecState
}



class SesionDetailController extends GetxController{
  late SesionDetailState _state;
  late QuestionModel _questionModel;

  late String _questionText;
  late String _questionId;

  late String _sesionid;
  late String _sesionAtendessid;
  late AnswerModel _answerModel;

  String? _answerId;

  String get answerId => _answerId??"";

  set answerId(String value) {
    _answerId = value;
    update();
  }

  String? _answerText;


  late int? _questionmarkcount = 9999;


  late int _setmark;
  late String _feedbacktext ="";
  late int _markcheck = 0;

  int get markcheck => _markcheck;

  set markcheck(int value) {
    _markcheck = value;
    update();
  }

  String get feedbacktext => _feedbacktext;

  set feedbacktext(String value) {
    _feedbacktext = value;
    update();
  }

  late FeedbackModel feedbackModel = FeedbackModel(reviewOwner: "giriş yapan kullanıcı", reviews: [] , avgMark: 0);

  late List<ListItemModel> _itemList = [];

  List<ListItemModel> get itemList => _itemList;

  set itemList(List<ListItemModel> value) {
    _itemList = value;
    update();
  }

  int get questionmarkcount => _questionmarkcount  ??0;

  set questionmarkcount(int? value) {
    _questionmarkcount = value;
    update();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    _questionmarkcount = 9999;


    _setmark = 9999;
    _feedbacktext ="";
    _markcheck = 0;
    feedbackModel = FeedbackModel(reviewOwner: "giriş yapan kullanıcı", reviews: [] , avgMark: 0);

    _state = SesionDetailState.SecState;
  }


  final LocalStorage storage = new LocalStorage('app');
  String get answerText => _answerText ??"";
  set answerText(String value) {
    _answerText = value;
    update();
  }
  int get setmark => _setmark;
  set setmark(int value) {
    _setmark = value;
    update();
  }
  String get questionId => _questionId;
  set questionId(String value) {
    _questionId = value;
    print("questionId" + value);
    update();
  }
  AnswerModel get answerModel => _answerModel;
  set answerModel(AnswerModel value) {
    _answerModel = value;
    update();
  }
  String get sesionAtendessid => _sesionAtendessid;
  set sesionAtendessid(String value) {
    _sesionAtendessid = value;
    update();

  }
  String get sesionid => _sesionid;
  set sesionid(String value) {
    _sesionid = value;
    update();
    print("attentsid"+sesionAtendessid);

    GetSesions();

  }
  String get questionText => _questionText;
  set questionText(String value) {
    _questionText = value;
    update();
  }
  QuestionModel get questionModel => _questionModel;
  set questionModel(QuestionModel value) {
    _questionModel = value;
    update();
  }
  SesionDetailState get state => _state;
  set state(SesionDetailState value) {
    _state = value;
    update();
  }

  void savefeedback(String feedback , int mark) async{
    String email =  await storage.getItem("email");
    feedbackModel.reviewOwner = email;
    if(feedbackModel.reviews!.isNotEmpty){
      bool check = feedbackModel.reviews!.any((review) => review.questionId == questionId);
      if(check){
        Get.snackbar("Error", "feedback and mark is registered.",
            colorText: Colors.white,
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            backgroundColor: Colors.red);
      }else{
        feedbackModel.reviews?.add(Review(questionId: questionId, answerId: answerId, mark: mark, feedback: feedback));
        questionmarkcount = questionmarkcount -1;
        _itemList.add(ListItemModel(questionId: questionId, mark: mark, feedback: feedback));
        Get.snackbar("Error", "Feedback Save ",
            colorText: Colors.white,
            icon: Icon(
              Icons.assignment_turned_in_sharp,
              color: Colors.white,
            ),
            backgroundColor: Colors.green);
      }
      int toplamMark = 0;
      feedbackModel.reviews!.forEach((review) {
        toplamMark += review.mark ?? 0;
      });
      int reviewSayisi = feedbackModel.reviews!.length;
      double ortalamaMark = reviewSayisi > 0 ? toplamMark / reviewSayisi : 0;
      feedbackModel.avgMark = ortalamaMark;
    }else{
      feedbackModel.reviews?.add(Review(questionId: questionId, answerId: answerId, mark: mark, feedback: feedback));
      questionmarkcount = questionmarkcount -1;
      _itemList.add(ListItemModel(questionId: questionId, mark: mark, feedback: feedback));
      Get.snackbar("Error", "Feedback Save ",
          colorText: Colors.white,
          icon: Icon(
            Icons.assignment_turned_in_sharp,
            color: Colors.white,
          ),
          backgroundColor: Colors.green);
    }



  }


  void GetSesions() async {

    setmark = 0;
    feedbacktext ="";



    state = SesionDetailState.LoadingState;

    String token =  "Bearer "+await storage.getItem("token");

    String email =  await storage.getItem("email");

    String url = "api/session/session/"+_sesionid+"/attendee/"+_sesionAtendessid+"/get/answers";

    print(url);
    Request request = Request(url: url);
    await request.get(token).then((value) async{
      var json = jsonDecode(value);
      if(json['success']==true){
        AnswerModel model = AnswerModel.fromJson(json);
        _answerModel = model;
        if(answerModel.result!.length > 0){
          answerModel.result![0].answers!.forEach((element) {


            if(element.questionId == questionId){

              answerText = element.answerText??"";
              answerId = element.id ?? "";

              List<ListItemModel> list =  itemList.where((review) => review.questionId == element.questionId).toList();
              if(list.length > 0){
                markcheck = list[0].mark;
                feedbacktext = list[0].feedback;
              }else{
                markcheck = 0;
                feedbacktext = "";
              }




            }

          });
        }

        if(questionmarkcount == 9999){
          questionmarkcount = questionModel.sessionQuestions?.length;

        }

        state = SesionDetailState.LoadedState;
      }else{
        Get.snackbar("Error", json['message'],colorText: Colors.red,icon: Icon(Icons.error_outline,color: Colors.red,));
        state = SesionDetailState.ErrorState;

      }
    }).catchError((onError) {
      print(onError.toString());
      Get.snackbar("Error", "please try again later",colorText: Colors.red,icon: Icon(Icons.error_outline,color: Colors.red,));
      state = SesionDetailState.ErrorState;

    });
  }


  void sendReview()async{
    if(_sesionAtendessid == "" ||_sesionAtendessid.isEmpty){
      Get.snackbar("Error", "answer not found ! ",
          colorText: Colors.white,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          backgroundColor: Colors.red);
      return ;
    }
    //state = SesionDetailState.LoadingState;

    Request r = Request(
      url: "api/review/review/session/"+_sesionid+"/create/attendee/"+_sesionAtendessid,
      body: jsonEncode(feedbackModel),
    );
    print(feedbackModel.toString());
    String token =  "Bearer "+await storage.getItem("token");

    r.post(token).then((value) async {
      var json = jsonDecode(value);
      if (json['generated'] == true) {
        //state = SesionDetailState.LoadedState;

        Get.snackbar("Success", json['message'],
            colorText: Colors.white,
            icon: Icon(
              Icons.assignment_turned_in_sharp,
              color: Colors.white,
            ),
            backgroundColor: Colors.green);

      } else {
       // state = SesionDetailState.LoadedState;

        Get.snackbar("Error", json['message'],
            colorText: Colors.white,
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            backgroundColor: Colors.red);
      }
    }).catchError((onError) {
      //state = SesionDetailState.LoadedState;
      Get.snackbar("Error", onError,
          colorText: Colors.white,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          backgroundColor: Colors.red);
      print(onError);
    });



  }




}