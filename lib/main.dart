import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';
import 'Themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HİVE',
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      themeMode: ThemeMode.light,
    );
  }
}
