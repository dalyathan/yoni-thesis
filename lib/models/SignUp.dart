class SignUp {
  final String first_name;
  final String last_name;
  final String email;
  final String username;
  final String password;

  SignUp(this.first_name, this.last_name, this.email, this.username,
      this.password);

  factory SignUp.fromJson(Map<String, String> json) {
    return SignUp(json['first_name']!, json['last_name']!, json['email']!,
        json['username']!, json['password']!);
  }

  Map<String, String> toJson() {
    return <String, String>{
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return '$first_name $last_name $email $username $password';
  }
}
