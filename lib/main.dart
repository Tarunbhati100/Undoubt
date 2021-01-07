import 'package:Undoubt/Screens/Client/Client_Screen.dart';
import 'package:Undoubt/Screens/Welcome/welcome_screen.dart';
import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'UnDoubt',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'PatrickHand',
      ),
      home: StreamBuilder<User>(
          stream: AuthServices().user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ClientScreen();
            } else {
              return WelcomeScreen();
            }
          }),
    );
  }
}
