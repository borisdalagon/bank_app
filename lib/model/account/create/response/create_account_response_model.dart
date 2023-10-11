import 'package:bank_app/model/account/authentication/response/authenticate_response_model.dart';

class CreateAccountResponseModel {
  String? message;
  User? user;

  CreateAccountResponseModel({this.message, this.user});

  CreateAccountResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
