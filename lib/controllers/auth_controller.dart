import 'dart:convert';

import 'package:authapp/backend/api.dart';
import 'package:authapp/models/login_model.dart';
import 'package:authapp/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final dio = Dio();

  RxBool isAuthenticated = false.obs;

  // create user
  Future<UserModel> createUser(
    String name,
    String email,
    String password,
  ) async {
    print('Creating user with name: $name, email: $email');
    try {
      final response = await dio.post(
        Api.createUser,
        data: {
          // api data
          'name': name,
          'email': email,
          'password': password,
          "avatar": "https://picsum.photos/800",
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      // print(response.statusCode);
      // print(response.data);
      return userModelFromJson(json.encode(response.data));
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  // login user
  Future<LoginModel> loginUser(String email, String password) async {
    print('Logging in user with email: $email');
    try {
      final response = await dio.post(
        Api.login,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return loginModelFromJson(json.encode(response.data));
    } catch (e) {
      print('Error logging in user: $e');
      rethrow;
    }
  }
}
