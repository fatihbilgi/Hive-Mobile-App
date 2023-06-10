import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginController.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final LoginController controller = Get.put(LoginController());
    final organization = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();

    var width = Get.width;
    return GetBuilder<LoginController>(builder: (controller) {

      return
      SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Material(
              color: Color.fromRGBO(36, 3, 100, 1),
              child: Padding(
                padding: EdgeInsets.only(right: 35, left: 35),
                child: ListView(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Container(

                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Text("Welcome", style: TextStyle(
                                color: Color.fromRGBO(36, 3, 100, 1),
                                fontSize: 35)),

                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 15),
                              child: TextField(
                                controller: organization,

                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.home),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),

                                    ),

                                  ),
                                  hintText: "Organization",
                                  isDense: true,
                                  // Added this
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 15),
                              child: TextField(
                                controller: email,

                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))
                                  ),
                                  hintText: "Email",
                                  isDense: true,
                                  // Added this
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),


                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 15),
                              child: TextField(
                                controller: password,
                                obscureText: controller.showpassword,

                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      controller.showpassword ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme
                                          .of(context)
                                          .primaryColorDark,
                                    ),
                                    onPressed: () {
                                      controller.showpassword == false ? controller.showpassword = true : controller.showpassword = false;

                                    },
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))
                                  ),
                                  hintText: "Password",
                                  isDense: true,
                                  // Added this
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),




                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(

                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromRGBO(36, 3, 100, 1)),
                                ),
                                onPressed: () {
                                  controller.apiLogin(
                                      organization.value.text, email.value.text,
                                      password.value.text);
                                },
                                child:controller.loginState == LoginState.LoadingState?CircularProgressIndicator(color: Colors.white,): Text('Login',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

    });
  }




}



