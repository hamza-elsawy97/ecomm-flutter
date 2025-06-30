import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:authapp/controllers/auth_controller.dart';
import 'package:authapp/factory/assets.dart';
import 'package:authapp/factory/color_factory.dart';
import 'package:authapp/models/input_field_widget.dart';
import 'package:authapp/screens/login_screen.dart';
import 'package:authapp/screens/products.dart';
import 'package:dim_loading_dialog/dim_loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authCtrl = Get.put(AuthController());

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool isAgreed = false;

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
            // signup
            Text(
              'Sign Up',
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
            InputFieldWidget(controller: nameController, hintText: 'Name'),
            const SizedBox(height: 20),
            InputFieldWidget(controller: emailController, hintText: 'Email'),
            const SizedBox(height: 20),
            InputFieldWidget(
              controller: passwordController,
              hintText: 'Password',
              isPassword: true,
              // _obsecureText: true,
            ),
            const SizedBox(height: 20),
            // Terms & Conditions
            Row(
              children: [
                Checkbox(
                  value: isAgreed,
                  onChanged: (value) {
                    isAgreed = value ?? false;
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: ColorFactory.textGray),
                      children: [
                        const TextSpan(text: 'I\'m agree to The '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: ColorFactory.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Terms of Service tap
                            },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: ColorFactory.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Privacy Policy tap
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                    final user = await authCtrl.createUser(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                    print('User created: ${user.name}, ${user.email}');
                    //authCtrl.isAuthenticated.value = true; // user login
                    dimDialog.dismiss();
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.success,
                        title: "User Created",
                        text: "${user.name} has been successfully created.",
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
                  } catch (e) {
                    print('Error creating user: $e');
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
                  'Create Account',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Already have an account?
            Row(
              children: [
                Text('Do you have account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Sign In',
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
