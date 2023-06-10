import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/Screens/SesionDetail/SesionDetail.dart';

import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../Core/ErrorWidget.dart';
import '../../Models/QuestionModel.dart';
import 'HomeController.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
     return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(36, 3, 100, 1),
          title: Text("Reviews"),
          actions: [
            IconButton(onPressed: (){
              Get.toNamed("LOGIN");
            }, icon: Icon(Icons.logout,color: Colors.white),color: Colors.white,)
            ],
        ),
        body:
        controller.state == HomeState.LoadingState ? Center(child: CircularProgressIndicator(),) : controller.state == HomeState.ErrorState ? GlobalErrorWidget(errorMsg: "Lütfen Tekrar deneyin",onRefresh: controller.GetSesions):
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 35),
              child: Container(
                width: Get.width/2,
                height: 40,
                child: Center(child: const Text("Sessions")),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.GetSesions(); // Void fonksiyonunu burada tetikliyoruz
                },
                child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller?.response?.result?.length,
                itemBuilder: (context, index) {
                return  Padding(
                  padding:  EdgeInsets.only(top: 15, left: 25, right: 25),
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(2.0, 3.0),
                        )
                      ],

                    ),
                    child: Center(child: TextButton(
                      child: Text(
                          controller.response.result?[index].sessionName ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        var value = await showTopModalSheet<String?>(context, SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Sesion User",
                                    style: TextStyle(color: Color.fromRGBO(36, 3, 100, 1), fontSize: 20),
                                    textAlign: TextAlign.center),

                                Container(
                                  height: Get.height/3,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:  controller.response.result[index].sessionAttendees.length,
                                    itemBuilder: (cont, ind) {
                                      return
                                        Padding(
                                          padding:  EdgeInsets.only(left: 10, right: 5),
                                          child: OutlinedButton(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 2),
                                                  child: TextButton(onPressed: () {

                                                    var a = QuestionModel.fromJson(controller.response.result[index].toJson());
                                                    var atendid = controller.response.result[index].sessionAttendees[ind].id;

                                                    Get.to(SesionDetail(questionModel: a,atendid: atendid??"",));

                                                  },
                                                  child: Text(controller.response.result[index].sessionAttendees[ind].attendeeName)),
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop("");
                                            },
                                          ),
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),);


                      },
                    ),
                    ),
                  ),
                );



    }),
              ),
            ),
            SizedBox(height: 8)
          ],
        ),
      );
  });
  }
}

