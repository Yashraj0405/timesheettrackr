import 'package:flutter/material.dart';
import 'package:timesheettrackr/home/view/home.dart';
import 'package:timesheettrackr/signup/view/signup.dart';
import './login/view/login.dart';
import './constants/theme.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body : Login()
      ),
      routes: {
        Login.routeName :(context) => Login(),
        SignUp.routeName: (context) => SignUp(),
        HomePage.routeName: (context)=> HomePage(),
      },
    );
  }
}
