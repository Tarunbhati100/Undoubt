import 'package:Undoubt/Screens/Client/components/add_Doubt.dart';
import 'package:Undoubt/Screens/Client/components/body.dart';
import 'package:Undoubt/Screens/Welcome/welcome_screen.dart';
import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/Client.dart';
import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  final _database = DatabaseServices();
  final _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () async {
            final client =
                await _database.clientData(_auth.getCurrentUser().uid);
            showProfile(context, client);
          },
        ),
        title: Text("Client Section"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                AuthServices().signOut();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                }));
              })
        ],
      ),
      body: SafeArea(child: Body()),
      floatingActionButton: GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: FittedBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                  ),
                  Text("Ask Doubt", style: TextStyle(color: Colors.white)),
                ],
              ),
            )),
        onTap: () {
          raiseDoubt(context);
        },
      ),
    );
  }

  void raiseDoubt(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(29),
          topRight: Radius.circular(29),
        )),
        context: context,
        builder: (_) {
          return add_Doubt();
        });
  }

  void showProfile(BuildContext context, Client client) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(29),
          topRight: Radius.circular(29),
        )),
        context: context,
        builder: (_) {
          return Container(
            child: Column(
              children: [
                Text(
                  "Name :- ${client.name}",
                  style: TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Email Id :- ${client.emailid}",
                  style: TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Mobile Number :- ${client.number}",
                  style: TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Address :- ${client.address}",
                  style: TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
