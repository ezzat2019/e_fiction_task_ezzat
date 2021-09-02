import 'package:e_fiction_task_ezzat/ui/auth/login_screen.dart';
import 'package:e_fiction_task_ezzat/ui/home/provider/home_provider.dart';
import 'package:e_fiction_task_ezzat/utils/heleprs/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiction Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: UiHelper.primaryColor,
          accentColor: UiHelper.secondaryColor),
      home: LoginScreen(),
    );
  }
}
