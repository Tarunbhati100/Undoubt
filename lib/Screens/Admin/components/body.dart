import 'package:Undoubt/Screens/Admin/AdminScreen/components/background.dart';
import 'package:Undoubt/Screens/Answer_Screen.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/Query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: StreamBuilder<List<Query>>(
      stream: DatabaseServices().adminqueries,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(child: SvgPicture.asset("assets/images/doubt.svg"));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Queries :- ",
                  style: TextStyle(
                      fontSize: 30,
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline),
                ),
              ),
              Column(
                  children: List.generate(snapshot.data.length, (index) {
                var element = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                      return AnswerScreen();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: kPrimaryColor),
                      color: kPrimaryLightColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Question :- ${element.question}",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 0.51,
                        ),
                        Text(
                          "Description :- ${element.description}",
                          style: TextStyle(
                            fontSize: 15,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
            ],
          );
        }
      },
    ));
  }
}
