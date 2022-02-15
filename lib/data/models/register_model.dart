class RegisterModel {
  bool? success;
  Data? data;

  RegisterModel({this.success, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? type;
  Null? image;
  int? status;
  Null? description;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? rate;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.image,
        this.status,
        this.description,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.rate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    image = json['image'];
    status = json['status'];
    description = json['description'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['image'] = this.image;
    data['status'] = this.status;
    data['description'] = this.description;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rate'] = this.rate;
    return data;
  }
}
