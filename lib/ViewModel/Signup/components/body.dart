import 'package:evaluation_task/Controllers/signup_controller.dart';
import 'package:evaluation_task/Utils/navigation.dart';
import 'package:evaluation_task/ViewModel/Login/components/background.dart';

import 'package:evaluation_task/components/already_have_an_account_acheck.dart';
import 'package:evaluation_task/components/rounded_button.dart';
import 'package:evaluation_task/components/rounded_input_field.dart';
import 'package:evaluation_task/components/rounded_password_field.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  String? email, pass;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Enter your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(onChanged: (value) {
              pass = value;
            }),
            RoundedButton(
                text: "SIGNUP",
                press: () {
                  SignUpController signUpController = SignUpController();
                  signUpController.signupViaMailAndPass(context, email!, pass!);
                }),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                NavigationService.instance.navigateTo("/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}
