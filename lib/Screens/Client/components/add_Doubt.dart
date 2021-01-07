import 'package:Undoubt/Services/auth.dart';
import 'package:Undoubt/Services/database.dart';
import 'package:Undoubt/constants.dart';
import 'package:Undoubt/models/Query.dart';
import 'package:flutter/material.dart';

class add_Doubt extends StatefulWidget {
  @override
  _add_DoubtState createState() => _add_DoubtState();
}

class _add_DoubtState extends State<add_Doubt> {
  String question;
  String description;
  final _auth = AuthServices();
  final _database = DatabaseServices();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        left: 10,
        right: 10,
      ),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Question",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: kPrimaryColor, style: BorderStyle.solid, width: 2),
                ),
              ),
              onChanged: (val) {
                question = val;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 8,
                maxLength: 1000,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kPrimaryColor,
                        style: BorderStyle.solid,
                        width: 2),
                  ),
                ),
                onChanged: (val) {
                  description = val;
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
                final user = _auth.getCurrentUser();
                await _database.addQuery(
                    Query(
                        id: user.uid,
                        question: question,
                        description: description,
                        client: user.email),user.uid);
              },
              child: FittedBox(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.message),
                    ),
                    Text(
                      "Raise Query",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
