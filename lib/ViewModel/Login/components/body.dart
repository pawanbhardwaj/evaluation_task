import 'package:evaluation_task/Controllers/login_controller.dart';
import 'package:evaluation_task/Utils/navigation.dart';
import 'package:evaluation_task/components/or_divider.dart';

import 'package:evaluation_task/components/already_have_an_account_acheck.dart';
import 'package:evaluation_task/components/rounded_button.dart';
import 'package:evaluation_task/components/rounded_input_field.dart';
import 'package:evaluation_task/components/rounded_password_field.dart';
import 'package:evaluation_task/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? _email, _pass;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.015),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.015),
              RoundedInputField(
                hintText: "Enter your Email",
                onChanged: (value) {
                  _email = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  _pass = value;
                },
              ),
              RoundedButton(
                  text: "LOGIN",
                  press: () {
                    LoginController loginController = LoginController();
                    loginController.loginViaMailIdAndPass(
                        context, _email!, _pass!);
                  }),
              OrDivider(),
              Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(11)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 11),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: (val) {
                          if (val == '' || val == null || val.length < 10)
                            return 'Please enter valid phone number';
                          else
                            return null;
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  LoginController loginController =
                                      LoginController();
                                  loginController.loginUserViaMobile(
                                    _phoneController,
                                    _otpController,
                                    context,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 21,
                              )),
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontFamily: "AlteHaasGrotes"),
                          hintText: "Enter Number",
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: true,
                press: () {
                  NavigationService.instance.navigateTo("/signup");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
