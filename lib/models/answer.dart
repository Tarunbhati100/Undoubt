class Answer {
  final String questionid;
  final String answerid;
  final String answer;
  final String admin;
  final String admintype;
  final double rating;
  Answer({
    this.questionid,
    this.answerid,
    this.answer,
    this.admin,
    this.admintype,
    this.rating,
  });

  Map<String, String> get tomap {
    return {
      'QuestionId': questionid,
      'Answer': answer,
      'AnsweredBy': admin,
      'AdminType': admintype,
    };
  }
}
