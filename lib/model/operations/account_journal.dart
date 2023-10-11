class AccountJournal {
  int? accountId;
  String? direction;
  int? amount;
  String? balanceBefore;
  int? balanceAfter;
  String? updatedAt;
  String? createdAt;
  int? id;

  AccountJournal(
      {this.accountId,
      this.direction,
      this.amount,
      this.balanceBefore,
      this.balanceAfter,
      this.updatedAt,
      this.createdAt,
      this.id});

  AccountJournal.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    direction = json['direction'];
    amount = json['amount'];
    balanceBefore = json['balance_before'];
    balanceAfter = json['balance_after'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['direction'] = this.direction;
    data['amount'] = this.amount;
    data['balance_before'] = this.balanceBefore;
    data['balance_after'] = this.balanceAfter;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
