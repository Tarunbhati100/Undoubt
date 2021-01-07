class Query {
  final String questionid;
  final String question;
  final String description;
  final String client;
  Query({this.questionid,this.question,this.description,this.client});

  Map<String, String> get tomap {
    return {
      'postedby':client,
      'Question': question,
      'Description' :description,
    };
  }
}
