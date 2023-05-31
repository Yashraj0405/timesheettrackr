import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheettrackr/home/view/home.dart';
import 'package:timesheettrackr/signup/view/signup.dart';
import './login/view/login.dart';
import './constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp(token: preferences.getString('accessToken'))
  );
}

class MyApp extends StatelessWidget {
  final token;
  MyApp({required this.token, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Widget initialScreen;

    if (token == null) {
      initialScreen = Login();
    } else {
      if (JwtDecoder.isExpired(token)) {
        initialScreen = Login();
      } else {
        initialScreen = HomePage();
      }
    }

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: initialScreen
      ),
      routes: {
        Login.routeName: (context) => Login(),
        SignUp.routeName: (context) => SignUp(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
