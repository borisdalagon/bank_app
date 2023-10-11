
class AuthenticateRequestModel {

  String? email;
  String? password;

  AuthenticateRequestModel({this.email, this.password});

  AuthenticateRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}