import 'package:Undoubt/Screens/Login/PhoneLogin/components/background.dart';
import 'package:Undoubt/Screens/Login/PhoneLogin/OTPScreen.dart';
import 'package:Undoubt/Screens/Login/PhoneLogin/components/wrapping_Container.dart';
import 'package:Undoubt/constants.dart';
import 'package:flutter/material.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              WrappingContainer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+91'),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: FlatButton(
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(_phoneController.text)));
                },
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
