class Client {
  final String name;
  final String emailid;
  final String number;
  final String address;

  Client({this.emailid, this.address, this.name, this.number});

  Map<String, dynamic> get tomap {
    return {
      'Name': name,
      'EmailId': emailid,
      'Number': number,
      'Address': address,
    };
  }
}
