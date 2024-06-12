import 'package:chat_app_task/services/auth/auth_service.dart';
import 'package:chat_app_task/components/my_button.dart';
import 'package:chat_app_task/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // email an password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passordController = TextEditingController();
  // tap to go to register
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

// ligin method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passordController.text,
      );
    }
    // catch any error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60.0,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50.0,
            ),

            // welcome back message
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),

            // email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(
              height: 10.0,
            ),

            // pw textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passordController,
            ),
            const SizedBox(
              height: 25.0,
            ),

            // login button
            MyButtin(
              text: 'Login',
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 25.0,
            ),

            // register now

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member? ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
