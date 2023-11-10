class LoginModel {
  int? createdAt;
  String? token;
  String? id;
  String? user;
  String? password;

  LoginModel({this.createdAt, this.token, this.id, this.user, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      createdAt: json['createdAt'] as int?,
      token: json['token'] as String?,
      id: json['id'] as String?,
      user: json['user'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['token'] = token;
    data['id'] = id;
    data['user'] = user;
    data['password'] = password;
    return data;
  }
}
