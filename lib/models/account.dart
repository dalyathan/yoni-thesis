class Account {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String balance;
  final String imgUrl;

  Account(this.firstName, this.lastName, this.username, this.email,
      this.balance, this.imgUrl);

  factory Account.fromJson(Map json) {
    return Account(json['first_name']!, json['last_name']!, json['username']!,
        json['email']!, json['balance']!, json['img_url']!);
  }
}
