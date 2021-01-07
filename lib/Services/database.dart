import 'package:Undoubt/models/Client.dart';
import 'package:Undoubt/models/Query.dart' as querymodel;
import 'package:Undoubt/models/admin.dart';
import 'package:Undoubt/models/answer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final CollectionReference adminsCollection =
      FirebaseFirestore.instance.collection('admins');
  final CollectionReference clientsCollection =
      FirebaseFirestore.instance.collection('clients');
  final CollectionReference answerCollection =
      FirebaseFirestore.instance.collection('answers');

  Future<List<Map<String, dynamic>>> get getdata async {
    final doc = await adminsCollection.get();
    return doc.docs.map((e) => e.data()).toList();
  }

  Future<Admin> validateAdmin(String id, String password) async {
    var admin;
    await adminsCollection.get().then((doc) => doc.docs.forEach((element) {
          if (element.data()['id'] == id) {
            if (element.data()['password'] == password) {
              admin = Admin(
                id: id,
                type: element.data()['type'],
              );
            }
          }
        }));
    return admin;
  }

  Future addQuery(querymodel.Query query, String uid) async {
    await clientsCollection.doc(uid).collection('questions').add(query.tomap);
  }

  Future addAnswer(Answer answer) async {
    await answerCollection.add(answer.tomap);
  }

  Future addUserProfile({Client client, String uid}) async {
    await clientsCollection.doc(uid).set(client.tomap);
  }

  Future<Client> getUserProfile(String uid) async {
    final document = await clientsCollection.doc(uid).get();
    return Client(
      name: document.data()['Name'] ?? "",
      emailid: document.data()['EmailId'] ?? "",
      address: document.data()['Address'] ?? "",
      number: document.data()['Number'] ?? "",
    );
  }

  List<querymodel.Query> _clientqueryListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return querymodel.Query(
          id: doc.data()['Id'] ?? "",
          client: doc.data()['postedby'] ?? "",
          question: doc.data()['Question'] ?? "",
          description: doc.data()['Description'] ?? "");
    }).toList();
  }

  Stream<List<querymodel.Query>> clientqueries(String uid) {
    final questionCollection =
        clientsCollection.doc(uid).collection('questions');
    return questionCollection.snapshots().map(_clientqueryListFromSnapshots);
  }

  List<querymodel.Query> _adminqueryListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return querymodel.Query(
        id: doc.data()['Id'] ?? "",
        client: doc.data()['postedby'] ?? "",
        question: doc.data()['Question'] ?? "",
        description: doc.data()['Description'] ?? "",
      );
    }).toList();
  }

  Stream<List<querymodel.Query>> get adminqueries {
    final allquestionCollection =
        FirebaseFirestore.instance.collectionGroup("questions");
    return allquestionCollection.snapshots().map(_adminqueryListFromSnapshots);
  }

  List<Answer> _answerListFromSnapshots(QuerySnapshot snapshot, String id) {
    return snapshot.docs.map((doc) {
      return Answer(
          id: doc.data()['Id'] ?? "",
          answer: doc.data()['Answer'] ?? "",
          admin: doc.data()['AnsweredBy'] ?? "",
          admintype: doc.data()['AdminType'] ?? "");
    }).toList();
  }

  Stream<List<Answer>> answers(String id) {
    return answerCollection.snapshots().map((snapshot) {
      return _answerListFromSnapshots(snapshot, id);
    });
  }

  Future<Client> clientData(String uid) async {
    final doc = await clientsCollection.doc(uid).get();
    return Client(
      name: doc.data()['Name'],
      emailid: doc.data()['EmailId'],
      address: doc.data()['Adress'],
      number: doc.data()['Number'],
    );
  }
}