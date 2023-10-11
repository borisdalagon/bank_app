import 'package:bank_app/model/operations/account_journal.dart';

class DebitResponseModel {
  String? message;
  AccountJournal? accountJournal;

  DebitResponseModel({this.message, this.accountJournal});

  DebitResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accountJournal = json['account_journal'] != null
        ? new AccountJournal.fromJson(json['account_journal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.accountJournal != null) {
      data['account_journal'] = this.accountJournal!.toJson();
    }
    return data;
  }
}
