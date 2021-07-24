import 'package:evaluation_task/Utils/navigation.dart';
import 'package:evaluation_task/ViewModel/Login/login_screen.dart';
import 'package:evaluation_task/ViewModel/Signup/signup_screen.dart';
import 'package:evaluation_task/ViewModel/home_screen.dart';
import 'package:evaluation_task/constants.dart';
import 'package:evaluation_task/Utils/sharedpreference_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Utils/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();

  await Firebase.initializeApp();

  bool isLoggedIn = false;
  if (SharedPreferenceHelper.getUserId().isNotEmpty) {
    isLoggedIn = true;
    userid = SharedPreferenceHelper.getUserId();
    userName = SharedPreferenceHelper.getUserName();
  }
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task',
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Muli", primarySwatch: kPrimaryColor),
        routes: {
          "/login": (context) => LoginScreen(),
          "/signup": (context) => SignUpScreen(),
          "/home": (context) => HomeScreen()
        },
        home: !isLoggedIn ? LoginScreen() : HomeScreen());
  }
}
