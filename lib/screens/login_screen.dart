import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:authapp/controllers/auth_controller.dart';
import 'package:authapp/factory/assets.dart';
import 'package:authapp/factory/color_factory.dart';
import 'package:authapp/models/input_field_widget.dart';
import 'package:authapp/screens/products.dart';
import 'package:authapp/screens/signup_screen.dart';
import 'package:dim_loading_dialog/dim_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authCtrl = Get.put(AuthController());

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    DimLoadingDialog dimDialog = DimLoadingDialog(
      context,
      blur: 2,
      backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 500),
    );

    return Scaffold(
      //appBar: AppBar(title: const Text('Sign Up')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // signin
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: ColorFactory.textPrimary,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.',
              style: TextStyle(fontSize: 16, color: ColorFactory.textGray),
              textAlign: TextAlign.center,
            ),
            // Facebook & Google Sign Up Buttons
            const SizedBox(height: 20),
            _buildFaceboonAndGoogleAuth(),
            const SizedBox(height: 20),
            _buildSeperator(),
            const SizedBox(height: 20),
            InputFieldWidget(controller: emailController, hintText: 'Email'),
            const SizedBox(height: 20),
            InputFieldWidget(
              controller: passwordController,
              hintText: 'Password',
              isPassword: true,
            ),
            const SizedBox(height: 20),
            // Forgot Password
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.right,
                style: TextStyle(color: ColorFactory.textGray),
              ),
            ),
            const SizedBox(height: 20),
            // Submit button
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorFactory.primary.withValues(alpha: 0.5),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),

              child: ElevatedButton(
                onPressed: () async {
                  dimDialog.show();
                  try {
                    final user = await authCtrl.loginUser(
                      emailController.text,
                      passwordController.text,
                    );
                    print('User logged in: ${user.email}, ${user.password}');
                    //authCtrl.isAuthenticated.value = true; // user login
                    dimDialog.dismiss();
                    emailController.clear();
                    passwordController.clear();
                    ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.success,
                        title: "Login Successful",
                        text: "Welcome back, ${user.email}!",
                      ),
                    );
                    // Get.toNamed('/products');
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsScreen()),
                    );
                  } catch (e) {
                    print('Error logging in user: $e');
                    dimDialog.dismiss();
                    ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.danger,
                        title: "Login Failed",
                        text: "Invalid email or password. Please try again.",
                        // Get.toNamed('/products');
                        onConfirm: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  //TODO: Implement sign up logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorFactory.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Don't have an account?
            Row(
              children: [
                Text('Don’t have account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: ColorFactory.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceboonAndGoogleAuth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Facebook
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorFactory.buttonField,
            borderRadius: BorderRadius.circular(15),
          ),
          width: Get.width * 0.43, // Adjust width as needed
          height: 55,
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(Assets.facebook),
              ),
              const SizedBox(width: 10),
              const Text('Facebook', style: TextStyle()),
            ],
          ),
        ),
        const SizedBox(width: 10), // Space between buttons
        // Google
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorFactory.buttonField,
            borderRadius: BorderRadius.circular(15),
          ),
          width: Get.width * 0.43,
          height: 55,
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(Assets.google),
              ),
              const SizedBox(width: 10),
              const Text('Google', style: TextStyle()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeperator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //left side
        Expanded(child: Container(height: 1, color: ColorFactory.divider)),

        // Or text
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text('Or', style: TextStyle(color: ColorFactory.textGray)),
        ),

        //right side
        Expanded(child: Container(height: 1, color: ColorFactory.divider)),
      ],
    );
  }

  //
}
