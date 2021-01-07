import 'package:Undoubt/Screens/Client/Client_Screen.dart';
import 'package:Undoubt/Screens/Login/login_screen.dart';
import 'package:Undoubt/Screens/Login/PhoneLogin/phone_Login.dart';
import 'package:Undoubt/Screens/Signup/EnterDetailScreen.dart';
import 'package:Undoubt/Screens/Signup/signup_screen.dart';
import 'package:Undoubt/Screens/Welcome/components/background.dart';
import 'package:Undoubt/Screens/Welcome/components/or_divider.dart';
import 'package:Undoubt/Screens/Welcome/components/social_icon.dart';
import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/components/rounded_button.dart';
import 'package:Undoubt/constants.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  final _auth = AuthServices();
  final _database = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO UNDOUBT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () async {
                    try {
                      final user = await _auth.signInWithGoogle();
                      if (user != null) {
                        final client = await _database.clientData(user.uid);
                        if (client == null) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return EnterDetailScreen();
                          }), (route) => false);
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return ClientScreen(client : client);
                          }), (route) => false);
                        }
                      }
                    } catch (e) {
                      Flushbar(
                        icon: Icon(Icons.error_outline, color: Colors.red),
                        flushbarPosition: FlushbarPosition.TOP,
                        message: e.message,
                        duration: Duration(seconds: 3),
                      ).show(context);
                    }
                  },
                ),
                SocialIcon(
                    iconSrc: "assets/icons/telephone.svg",
                    press: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PhoneLoginPage();
                      }));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
