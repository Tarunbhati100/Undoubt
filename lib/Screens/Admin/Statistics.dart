import 'package:Undoubt/Screens/Admin/components/background.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/admin.dart';
import 'package:Undoubt/models/answer.dart';
import 'package:Undoubt/models/rating.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<Admin> admins = [];

  List<Answer> answers = [];

  final _database = DatabaseServices();
  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: Text(
          "Statistics",
          style: TextStyle(color: kPrimaryColor),
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: Background(
          child: ListView.builder(
              itemCount: admins.length,
              itemBuilder: (_, index) {
                final element = admins[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: kPrimaryColor,
                    padding: const EdgeInsets.all(2.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: Colors.white,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Row(
                            children: [
                              Text((index+1).toString()+". ",style: TextStyle(fontSize: 20),),
                              Icon(
                                Icons.account_circle,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      title: Text(
                        "Admin Id :- ${element.id}",
                      ),
                      subtitle: Text(
                          "${element.type} // Avg. Rating :- ${getAvgRating(element.id)}/5.0"),
                    ),
                  ),
                );
              })),
    );
  }

  initialize() async {
    final adminsdata = await _database.admins;
    final answerdata = await _database.answerslist;
    setState(() {
      admins = adminsdata;
      answers = answerdata;
    });
  }

  double getAvgRating(String admin) {
    int count = 0;
    double totalrating = 0;
    double avg = 0;
    answers.forEach((element) {
      if (element.admin == admin) {
        count++;
        totalrating += element.rating;
      }
    });
    avg = totalrating / count;
    return avg.isNaN ? 0 : avg;
  }
}
