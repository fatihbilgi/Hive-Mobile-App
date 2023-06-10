
import 'package:get/get.dart';



import '../Models/QuestionModel.dart';
import '../Screens/Home/HomePage.dart';
import '../Screens/Login/LoginPage.dart';
import '../Screens/SesionDetail/SesionDetail.dart';
import 'app_routes.dart';

class AppPages {

  static var list = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.SESIONDETAIL,
      page: () => SesionDetail(questionModel: QuestionModel(),atendid: ""),
    )


  ];
}
