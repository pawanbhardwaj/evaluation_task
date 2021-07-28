import 'package:evaluation_task/Utils/navigation.dart';
import 'package:evaluation_task/Utils/user.dart';

import 'package:evaluation_task/components/buildTimer.dart';
import 'package:evaluation_task/Utils/sharedpreference_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class LoginController {
  // login via mobile number and OTP
  Future loginUserViaMobile(String phone, TextEditingController _otpController,
      BuildContext context) async {
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
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);

        User? user = result.user;

        if (user != null) {
          _otpController.text = "OTP verified successfully";

          userid = user.uid;
          userName = "Guest";
          await SharedPreferenceHelper.setUserName(userName!);
          await SharedPreferenceHelper.setUserId(userid!);

          await NavigationService.instance
              .navigateToPushAndRemoveUntilRoute("/home");
        } else {
          print("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        if (exception.code == 'invalid-phone-number') {
          NavigationService.instance.goback();
          Fluttertoast.showToast(
              msg: 'The provided phone number is not valid.');
        } else {
          NavigationService.instance.goback();
          Fluttertoast.showToast(msg: exception.message!);
          Fluttertoast.showToast(msg: exception.toString());
        }
      },
      codeSent: (String? verificationId, [int? forceResendingToken]) {
        NavigationService.instance.goback();
        showModalBottomSheet(
            backgroundColor: Colors.white,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            context: context,
            builder: (BuildContext contex) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      padding: EdgeInsets.only(
                          right: 20.0, left: 20.0, top: 10.0, bottom: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildTimer(),
                          SizedBox(
                            height: 11,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffe3e3e3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 11, top: 6, bottom: 9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter the OTP sent to $phone",
                                    style: TextStyle(
                                      color: Color(0xffb2aeae),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          controller: _otpController,
                                          style: TextStyle(
                                            color: Color(0xff262626),
                                            fontSize: 16,
                                          ),
                                          keyboardType: TextInputType.number,
                                          maxLength: 6,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              counterText: ""),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          try {
                                            AuthCredential credential =
                                                PhoneAuthProvider.credential(
                                                    verificationId:
                                                        verificationId!,
                                                    smsCode:
                                                        _otpController.text);

                                            await FirebaseAuth.instance
                                                .signInWithCredential(
                                                    credential)
                                                .then((value) async {
                                              userid = value.user!.uid;
                                              userName = "Guest";

                                              await SharedPreferenceHelper
                                                  .setUserName(userName!);
                                              await SharedPreferenceHelper
                                                  .setUserId(userid!);
                                              await NavigationService.instance
                                                  .navigateToPushAndRemoveUntilRoute(
                                                      "/home");
                                            });

                                            _otpController.clear();
                                          } catch (e) {
                                            Fluttertoast.showToast(
                                                msg: "Invalid Code");
                                          }
                                        },
                                        child: Icon(
                                          Icons.forward,
                                          color: kPrimaryColor,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
            });
        Fluttertoast.showToast(
          msg: "Code sent",
          gravity: ToastGravity.BOTTOM,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Fluttertoast.showToast(msg: "Time out");
        // NavigationService.instance.goback();
      },
    );
  }

  // login via mail id and pass
  loginViaMailIdAndPass(BuildContext context, String mail, pass) async {
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
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: mail, password: pass);
      userid = userCredential.user!.uid;
      userName = mail;

      await SharedPreferenceHelper.setUserId(userid!);
      await SharedPreferenceHelper.setUserName(userName!);
      NavigationService.instance.goback();
      Fluttertoast.showToast(msg: "Successfully logged in");
      NavigationService.instance.navigateToPushAndRemoveUntilRoute("/home");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        NavigationService.instance.goback();
        Fluttertoast.showToast(msg: "Invalid Email");
      } else if (e.code == 'user-not-found') {
        NavigationService.instance.goback();
        Fluttertoast.showToast(msg: "User not found. Register here");
        NavigationService.instance.navigateTo("/signup");
      } else if (e.code == "wrong-password") {
        NavigationService.instance.goback();
        Fluttertoast.showToast(msg: "Wrong password");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
