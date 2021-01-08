import 'package:Undoubt/Screens/Login/components/background.dart';
import 'package:Undoubt/Screens/Login/login_screen.dart';
import 'package:Undoubt/Screens/Signup/EnterDetailScreen.dart';
import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/components/already_have_an_account_acheck.dart';
import 'package:Undoubt/components/rounded_button.dart';
import 'package:Undoubt/components/rounded_input_field.dart';
import 'package:Undoubt/components/rounded_password_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;

  String password;

  bool _showPassword = true;

  bool _showConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();

  final _auth = AuthServices();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ModalProgressHUD(
        inAsyncCall: isloading,
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    RoundedPasswordField(
                      title: "Password",
                      show: _showPassword,
                      toggle: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      onChanged: (val) {
                        password = val;
                      },
                      validator: (val) {
                        if (val.length < 6) {
                          return "Password must have atleast 6 characters !";
                        }
                        return null;
                      },
                    ),
                    RoundedPasswordField(
                      title: "Confirm Password",
                      show: _showConfirmPassword,
                      toggle: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                      validator: (val) {
                        if (val != password) return "Passwords don't match !";
                        return null;
                      },
                    ),
                    RoundedButton(
                      text: "SIGNUP",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isloading = true;
                          });
                          try {
                            final newUser =
                                await _auth.registerWithEmailAndPassword(
                                    emailid: email, password: password);

                            if (newUser != null) {
                              await _auth.signInWithEmailAndPassword(
                                  email, password);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return EnterDetailScreen();
                              }), (route) => false);
                            }
                          } catch (e) {
                            Flushbar(
                              icon:
                                  Icon(Icons.error_outline, color: Colors.red),
                              flushbarPosition: FlushbarPosition.TOP,
                              message: e.message,
                              duration: Duration(seconds: 3),
                            ).show(context);
                          } finally {
                            setState(() {
                              isloading = false;
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
