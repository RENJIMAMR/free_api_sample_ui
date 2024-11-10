import 'package:flutter/material.dart';
import 'package:token_test/view/home_screen/home_screen.dart';

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
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email")),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement login logic here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
