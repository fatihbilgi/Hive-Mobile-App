import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:hive/Screens/SesionDetail/DetailComponent.dart';

import '../../Models/QuestionModel.dart';
import 'SesionDetailController.dart';

class SesionDetail extends StatelessWidget {
  final QuestionModel questionModel;
  final String atendid;

  const SesionDetail({Key? key , required this.questionModel, required this.atendid }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SesionDetailController controller = Get.put(SesionDetailController());
    controller.questionModel = questionModel;

    return GetBuilder<SesionDetailController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(36, 3, 100, 1),
          title: Text("Answers"),
          actions: [
            IconButton(onPressed: (){
              Get.toNamed("LOGIN");
            }, icon: Icon(Icons.logout,color: Colors.white),color: Colors.white,)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 9,left: 9),
          child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
              return Column(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        height: 80.0,
                        child:  ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.questionModel.sessionQuestions?.length,
                        itemBuilder: (context, index) {
                                                return
                                                  Card(
                                                    color: Colors.blue,
                                                    child:  Container(
                                                      width: Get.width/4,
                                                      height: 50.0,
                                                      child: Center(child:  TextButton(child: Text(controller.questionModel.sessionQuestions?[index].questionTitle ?? "",style: TextStyle(color: Colors.white),), onPressed: () {



                                                        controller.sesionAtendessid = atendid;

                                                        controller.questionId = controller.questionModel.sessionQuestions?[index].id??"";

                                                        controller.questionText = controller.questionModel.sessionQuestions?[index].questionText ??"";
                                                        controller.sesionid = controller.questionModel.id ?? "";
                                                      },)),
                                                    ),
                                                  );



                        }
                        ),
                      ),
                    ],
                  ),

                  DetailCompanent(),
                  controller.questionmarkcount > 0?ElevatedButton(onPressed:(){ controller.savefeedback(controller.feedbacktext,controller.setmark);}, child: Text("Save Feedback",style: TextStyle(color: Color.fromRGBO(36, 3, 100, 1)),)):Text(""),

                  controller.questionmarkcount <=0?ElevatedButton(onPressed: (){
                    controller.sendReview();
                  },


                       child: controller.state == SesionDetailState.LoadingState ?CircularProgressIndicator():Text("Submit",style: TextStyle(color: Color.fromRGBO(36, 3, 100, 1)),)):Text(""),

                ],
              );


    }),
        ),
      );

    });


  }
}
