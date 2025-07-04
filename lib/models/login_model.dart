import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? email;
  final String? password;

  LoginModel({this.email, this.password});

  LoginModel copyWith({String? email, String? password}) => LoginModel(
    email: email ?? this.email,
    password: password ?? this.password,
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
