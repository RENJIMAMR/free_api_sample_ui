import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_test/controller/login_screen_controller.dart';
import 'package:token_test/global_widgets/custom_textfield.dart';
import 'package:token_test/global_widgets/refactored_button.dart';

import 'package:token_test/view/home_screen/home_screen.dart';
import 'package:token_test/view/registration_screen/registration_screen.dart'; // Import the registration screen

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              label: "Email",
              keyboardType:
                  TextInputType.emailAddress, // Optional, for email input
            ),
            CustomTextField(
              obscureText: true,
              controller: passwordController,
              label: "Password",
            ),
            SizedBox(height: 20),
            Consumer<LoginScreenController>(
                builder: (context, loginProv, child) {
              return loginProv.isLoading == true
                  ? CircularProgressIndicator()
                  : RefactoredButton(
                      label: "Login",
                      onTap: () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          bool? loginSuccess = await context
                              .read<LoginScreenController>()
                              .onLogin(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text);

                          if (loginSuccess == true) {
                            // Check explicitly for `true`
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Login Success"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          }
                          //  else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       backgroundColor: Colors.red,
                          //       content:
                          //           Text("Login failed. Please try again."),
                          //     ),
                          //   );
                          // }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Enter Valid Credentials"),
                            ),
                          );
                        }
                      },
                    );
            }),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegistrationScreen()), // Navigate to RegisterScreen
                );
              },
              child: Text("Don't have an account? Register now"),
            ),
          ],
        ),
      ),
    );
  }
}
