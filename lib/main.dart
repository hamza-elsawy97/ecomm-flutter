import 'package:authapp/screens/login_screen.dart';
import 'package:authapp/screens/products.dart';
import 'package:authapp/screens/signup_screen.dart';
import 'package:authapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/products',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/products', page: () => ProductsScreen()),
      ],
    );
  }
}
