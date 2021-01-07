import 'package:Undoubt/Screens/Admin/Admin_Screen.dart';
import 'package:Undoubt/Screens/Client/Client_Screen.dart';
import 'package:Undoubt/Screens/Login/components/background.dart';
import 'package:Undoubt/Screens/Login/components/login_Tab.dart';
import 'package:Undoubt/Screens/Signup/signup_screen.dart';
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

enum LoginType {
  client,
  admin,
}

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _showPassword = true;
  bool isClient = true;
  bool isloading = false;
  LoginType logintype = LoginType.client;
  final _formkey = GlobalKey<FormState>();
  final _auth = AuthServices();
  String email;
  String adminid;
  String password;
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
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginTab("Client Login", isClient, () {
                    if (logintype != LoginType.client) {
                      setState(() {
                        isClient = true;
                        logintype = LoginType.client;
                      });
                    }
                  }),
                  LoginTab("Admin Login", !isClient, () {
                    if (logintype != LoginType.admin) {
                      setState(() {
                        isClient = false;
                        logintype = LoginType.admin;
                      });
                    }
                  }),
                ],
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    RoundedInputField(
                      hintText: logintype == LoginType.client
                          ? "Your Email"
                          : "Admin ID",
                      onChanged: (value) {
                        logintype == LoginType.client
                            ? email = value
                            : adminid = value;
                      },
                    ),
                    RoundedPasswordField(
                      title: "Password",
                      show: _showPassword,
                      onChanged: (value) {
                        password = value;
                      },
                      toggle: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      validator: (val) {
                        if (val.length < 6) {
                          return "Password must have atleast 6 characters !";
                        }
                        return null;
                      },
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: () async {
                        if (_formkey.currentState.validate()) {
                          setState(() {
                            isloading = true;
                          });
                          try {
                            if (logintype == LoginType.client) {
                              final newUser = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (newUser != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) {
                                  return ClientScreen();
                                }), (route) => false);
                              }
                            } else if (logintype == LoginType.admin) {
                              final admin = await DatabaseServices()
                                  .validateAdmin(adminid, password);
                              if (admin != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) {
                                  return AdminScreen(admin: admin);
                                }), (route) => false);
                              }
                            }
                          } catch (e) {
                            Flushbar(
                              icon:
                                  Icon(Icons.error_outline, color: Colors.red),
                              flushbarPosition: FlushbarPosition.TOP,
                              message: logintype == LoginType.admin
                                  ? e.toString()
                                  : e.message,
                              duration: Duration(seconds: 3),
                            ).show(context);
                          } finally {
                            setState(() {
                              isloading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
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
