import 'package:Undoubt/Screens/Admin/Create_Admin.dart';
import 'package:Undoubt/Screens/Admin/Statistics.dart';
import 'package:Undoubt/Screens/Welcome/welcome_screen.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/admin.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  Admin admin;
  AdminDrawer({this.admin});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text("Hey ${admin.id}!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white)),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: kPrimaryColor,
            ),
            title: Text(
              "Create Admin",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CreateAdmin();
              }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              color: Colors.blue,
            ),
            title: Text(
              "Statistics",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Statistics();
              }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              "Sign Out",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return WelcomeScreen();
              }));
            },
          )
        ],
      ),
    );
  }
}
