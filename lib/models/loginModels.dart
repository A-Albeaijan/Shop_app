class LoginModels {
  bool? status;
  String? message;
  UserData? data;

  LoginModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // UserData(
  //     {this.id,
  //     this.credit,
  //     this.email,
  //     this.image,
  //     this.name,
  //     this.phone,
  //     this.points,
  //     this.token});

  //named constracter, Map json is the data that came
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}