class CreateAccountRequestModel {
  String? name;
  String? email;
  String? currency;
  String? password;

  CreateAccountRequestModel(
      {this.name, this.email, this.currency, this.password});

  CreateAccountRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    currency = json['currency'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['currency'] = this.currency;
    data['password'] = this.password;
    return data;
  }
}
