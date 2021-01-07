import 'package:Undoubt/Screens/Admin/components/background.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/Query.dart';
import 'package:Undoubt/models/admin.dart';
import 'package:Undoubt/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnswerScreen extends StatefulWidget {
  Admin admin;
  Query query;
  AnswerScreen({this.admin, this.query});

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final _database = DatabaseServices();

  String answer;

  double rating = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answers"),
        centerTitle: true,
      ),
      floatingActionButton: widget.admin != null
          ? GestureDetector(
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
                        Text("Answer Doubt",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )),
              onTap: () {
                answerDoubt(context);
              },
            )
          : SizedBox(),
      body: SafeArea(
          child: Background(
              child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: kPrimaryColor),
              color: kPrimaryLightColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Question :- ${widget.query.question}",
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
                      "Description :- ${widget.query.description}",
                      style: TextStyle(
                        fontSize: 15,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      "Posted by :- ${widget.query.client}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Answers",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          SingleChildScrollView(
            child: StreamBuilder<List<Answer>>(
              stream: DatabaseServices().answers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          children:
                              List.generate(snapshot.data.length, (index) {
                        var element = snapshot.data[index];
                        return (element.questionid == widget.query.questionid)
                            ? GestureDetector(
                                onTap: () {
                                  if (widget.admin == null) {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Give Rating'),
                                          content: FittedBox(
                                            child: RatingBar.builder(
                                              initialRating: 3,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (val) {
                                                rating = val;
                                              },
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Submit'),
                                              onPressed: () async {
                                                print(rating);
                                                await _database.addrating(
                                                    answerid: element.answerid,
                                                    adminid: element.admin,
                                                    rating: rating);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: kPrimaryColor),
                                    color: kPrimaryLightColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          element.answer,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: FittedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Answered By :- ${element.admin}(${element.admintype})",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              element.rating != null
                                                  ? Text(
                                                      "Rating :- ${element.rating}/5",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      })),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ))),
    );
  }

  void answerDoubt(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(29),
          topRight: Radius.circular(29),
        )),
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Answer",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kPrimaryColor,
                            style: BorderStyle.solid,
                            width: 2),
                      ),
                    ),
                    onChanged: (val) {
                      answer = val;
                    },
                  ),
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29),
                      side: BorderSide(color: Colors.white, width: 2)),
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (answer != "" && answer != null && answer.isNotEmpty) {
                      await _database.addAnswer(Answer(
                          questionid: widget.query.questionid,
                          admin: widget.admin.id,
                          admintype: widget.admin.type,
                          answer: answer));
                    }
                    Navigator.pop(context);
                  },
                  child: FittedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.message),
                        ),
                        Text(
                          "Answer Query",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
