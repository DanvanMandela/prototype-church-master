class User {
  int id;
  String user_id;
  String mobile;
  String email;
  String password;
  String created_at;

  User({this.user_id, this.mobile, this.email, this.password, this.created_at});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      user_id: json['user_id'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      created_at: json['created_at'] as String,
    );
  }
}
