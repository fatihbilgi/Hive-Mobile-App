
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:hive/Core/ErrorWidget.dart';

import 'SesionDetailController.dart';
class DetailCompanent extends StatefulWidget {
  const DetailCompanent({Key? key}) : super(key: key);

  @override
  State<DetailCompanent> createState() => _DetailCompanentState();
}

class _DetailCompanentState extends State<DetailCompanent> {
  var txt = TextEditingController();
  final SesionDetailController controller = Get.put(SesionDetailController());



  @override
  Widget build(BuildContext context) {


    if (controller.state == SesionDetailState.LoadedState) {
      return Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height/8,
            child: SingleChildScrollView(
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Question Description : "+controller.questionText),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(36, 3, 100, 1)),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          SizedBox(height: 8,),
          Container(
            width: Get.width,
            height: Get.height/4,
            child: SingleChildScrollView(
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: controller.answerModel.result?.length == 0 ? Text("Answer not found") : controller.answerText == null ?CircularProgressIndicator() : Text( controller.answerText ??"" ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(36, 3, 100, 1)),
                borderRadius: BorderRadius.circular(10)


            ),
          ),
          SizedBox(height: 8,),
          Center(child: Text("MARK")),

          controller.markcheck != 0 ?Text("Selected Mark : "+ controller.markcheck.toString(),style: TextStyle(color: Colors.red),) :
          InputQty(
            maxVal: 100,
            initVal: 0,
            minVal: 0,
            isIntrinsicWidth: false,
            borderShape: BorderShapeBtn.circle,
            boxDecoration: const BoxDecoration(),
            steps: 10,

            onQtyChanged: (val) {
              if(val == 0 && controller.setmark == 0){

              }else{
                print(val.toString());
                controller.setmark = int.parse(val.toString());



              }
            },
          ),
          SizedBox(height: 8,),
          TextField(
            maxLines: 8,
            onChanged: (text) {
              controller.feedbacktext = text;
            },

            decoration: InputDecoration.collapsed(hintText: controller.feedbacktext.isEmpty? "  Please give feedback":controller.feedbacktext,

              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(36, 3, 100, 1)),
              ),
            ),
          ),
        ],
      );
    } else {
      return controller.state == SesionDetailState.LoadingState ? Center(child: CircularProgressIndicator(),):controller.state == SesionDetailState.ErrorState ? GlobalErrorWidget(onRefresh: (){}, errorMsg: "Lütfen Tekrar Deneyin"):Center(child: Text(" Lütfen Soru Seç!"));
    }
  }
}

