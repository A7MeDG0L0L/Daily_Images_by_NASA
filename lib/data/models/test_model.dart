class TestModel {
  late int userID;
  late int type;
  late int status;
  late String token;

  TestModel({
    required this.userID,
    required this.type,
    required this.status,
    required this.token,
});
  TestModel.fromJson(Map<String,dynamic>json){

    userID = json['user'];
    type = json['type'];
    status = json['status'];
    token = json['token'];

  }

}