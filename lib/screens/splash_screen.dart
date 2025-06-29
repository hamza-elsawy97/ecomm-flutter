import 'package:authapp/factory/assets.dart';
import 'package:authapp/factory/color_factory.dart';
import 'package:authapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    // Get.off('/signup');
    // Get.offAllNamed('/signup');
    Get.off(() => SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFactory.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                border: Border.all(color: ColorFactory.accent),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.asset(Assets.logo, width: 100, height: 100),
              ),
            ),
            // Lottie.asset('assets/svg/gaza.json', width: 100, height: 100),
            Lottie.asset(Assets.gaza, width: 80, height: 100),
            Text(
              'Auth App',
              style: TextStyle(
                color: ColorFactory.background,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorFactory.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
