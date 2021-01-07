class Answer {
  final String id;
  final String answer;
  final String admin;
  final String admintype;
  Answer({this.id, this.answer, this.admin, this.admintype});

  Map<String, String> get tomap {
    return {
      'Id': id,
      'Answer': answer,
      'AnsweredBy': admin,
      'AdminType': admintype,
    };
  }
}
