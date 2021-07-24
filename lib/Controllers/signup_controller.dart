import 'package:evaluation_task/Utils/navigation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpController {
  signupViaMailAndPass(BuildContext context, String email, String pass) async {
    try {
      showDialog(
          context: (context),
          builder: (BuildContext context) => Container(
                child: Center(
                  child: SpinKitWave(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ));
      var auth = FirebaseAuth.instance;

      await auth.createUserWithEmailAndPassword(email: email, password: pass);

      NavigationService.instance.goback();
      Fluttertoast.showToast(msg: "Account created succesfully");

      NavigationService.instance.navigateToReplacement("/login");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        NavigationService.instance.goback();
        Fluttertoast.showToast(msg: "Email already taken");
      } else if (e.code == 'invalid-email') {
        NavigationService.instance.goback();
        Fluttertoast.showToast(msg: "Invalid Email");
      } else if (e.code == "weak-password") {
        NavigationService.instance.goback();
        Fluttertoast.showToast(msg: "Password should be at least 6 characters");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
