class Query {
  final String id;
  final String question;
  final String description;
  final String client;
  Query({this.id,this.question,this.description,this.client});

  Map<String, String> get tomap {
    return {
      'Id':id,
      'postedby':client,
      'Question': question,
      'Description' :description,
    };
  }
}
