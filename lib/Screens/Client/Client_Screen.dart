import 'package:Undoubt/Screens/Client/components/add_Doubt.dart';
import 'package:Undoubt/Screens/Client/components/body.dart';
import 'package:Undoubt/Screens/Signup/EnterDetailScreen.dart';
import 'package:Undoubt/Screens/Welcome/welcome_screen.dart';
import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/Client.dart';
import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  final _database = DatabaseServices();
  final _auth = AuthServices();
  Client client;
  ClientScreen({this.client});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () async {
            if (client == null) {
              client = await _database.clientData(_auth.getCurrentUser().uid);
            }
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(Icons.edit, color: kPrimaryColor),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EnterDetailScreen();
                    }));
                  }),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      icon: Icon(
                        Icons.account_circle,
                        color: kPrimaryColor,
                      ),
                      title: "Name : ${client.name}",
                    ),
                    Card(
                      icon: Icon(
                        Icons.email,
                        color: kPrimaryColor,
                      ),
                      title: "Email Id :- ${client.emailid}",
                    ),
                    Card(
                      icon: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                      title: "Mobile Number :- ${client.number}",
                    ),
                    Card(
                      icon: Icon(
                        Icons.location_city,
                        color: kPrimaryColor,
                      ),
                      title: "Address :- ${client.address}",
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class Card extends StatelessWidget {
  Icon icon;
  String title;
  Card({
    this.icon,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
