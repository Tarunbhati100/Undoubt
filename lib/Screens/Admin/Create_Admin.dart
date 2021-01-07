import 'package:Undoubt/Screens/Admin/components/Tab.dart';
import 'package:Undoubt/Screens/Login/components/background.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/components/rounded_button.dart';
import 'package:Undoubt/components/rounded_input_field.dart';
import 'package:Undoubt/components/rounded_password_field.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/admin.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

enum AdminType { admin, coadmin }

class CreateAdmin extends StatefulWidget {
  @override
  _CreateAdminState createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  bool _showPassword = true;
  bool _showConfirmPassword = true;
  bool isloading = false;
  final _formkey = GlobalKey<FormState>();
  final _database = DatabaseServices();
  AdminType admintype = AdminType.admin;
  bool isadmin = true;
  String adminid;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: Text(
          "Create Admin",
          style: TextStyle(color: kPrimaryColor),
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: Background(
        child: ModalProgressHUD(
          inAsyncCall: isloading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdminTab("Admin", isadmin, () {
                      if (admintype != AdminType.admin) {
                        setState(() {
                          isadmin = true;
                          admintype = AdminType.admin;
                        });
                      }
                    }),
                    AdminTab("Co-Admin", !isadmin, () {
                      if (admintype != AdminType.coadmin) {
                        setState(() {
                          isadmin = false;
                          admintype = AdminType.coadmin;
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
                        hintText: "Admin ID",
                        onChanged: (value) {
                          adminid = value;
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
                        text: "Create Admin",
                        press: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              final admins = await _database.admins;
                              if (!adminpresent(adminid, admins)) {
                                await _database.addAdminProfile(
                                    adminId: adminid,
                                    adminType: admintype == AdminType.admin
                                        ? "admin"
                                        : "coadmin",
                                    password: password);
                                Flushbar(
                                  icon: Icon(Icons.account_circle,
                                      color: Colors.green),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: "Admin Created Successfully",
                                  duration: Duration(seconds: 3),
                                ).show(context);
                              } else {
                                Flushbar(
                                  icon: Icon(Icons.account_circle,
                                      color: Colors.green),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: "Admin Id already exist",
                                  duration: Duration(seconds: 3),
                                ).show(context);
                              }
                            } catch (e) {
                              Flushbar(
                                icon: Icon(Icons.error_outline,
                                    color: Colors.red),
                                flushbarPosition: FlushbarPosition.TOP,
                                message: e.toString(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool adminpresent(String admin, List<Admin> admins) {
    bool flag = false;
    admins.forEach((element) {
      if (admin == element.id) {
        flag = true;
      }
    });
    return flag;
  }
}
