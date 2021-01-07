import 'package:Undoubt/Screens/Client/Client_Screen.dart';
import 'package:Undoubt/Screens/Client/components/background.dart';
import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/components/rounded_button.dart';
import 'package:Undoubt/components/rounded_input_field.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/Client.dart';
import 'package:flutter/material.dart';

class EnterDetailScreen extends StatelessWidget {
  String name;
  String emailId;
  String contactNumber;
  String address;
  final _formkey = GlobalKey<FormState>();
  final _database = DatabaseServices();
  final _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Background(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text("Enter Your Details",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RoundedInputField(
                        hintText: "Your Name",
                        icon: Icons.account_circle,
                        onChanged: (val) {
                          name = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Must not be empty !";
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Email Id",
                        keyboardtype: TextInputType.emailAddress,
                        icon: Icons.email,
                        onChanged: (val) {
                          emailId = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Must not be empty !";
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Contact Number",
                        icon: Icons.phone,
                        keyboardtype: TextInputType.phone,
                        onChanged: (val) {
                          contactNumber = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Must not be empty !";
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Address",
                        icon: Icons.location_city,
                        onChanged: (val) {
                          address = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Must not be empty !";
                          }
                          return null;
                        },
                      ),
                      RoundedButton(
                        text: "Submit",
                        press: () async {
                          if (_formkey.currentState.validate()) {
                            final client = Client(
                              name: name,
                              number: contactNumber,
                              address: address,
                              emailid: emailId,
                            );
                            await _database.addUserProfile(
                                uid: _auth.getCurrentUser().uid,
                                client: client);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return ClientScreen(client: client);
                            }), (route) => false);
                          }
                        },
                      )
                    ],
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
