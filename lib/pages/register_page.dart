import 'package:chat_app_task/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  // email an password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passordController = TextEditingController();
  final TextEditingController _confirmPassordController =
      TextEditingController();
// tap to go to login
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method

  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();
    // password match -> create user
    if (_passordController.text == _confirmPassordController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _passordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    // password done macth -> show error to user

    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords do't match!"),
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
              "Create an account for you!",
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
              height: 10.0,
            ),

            // confirm pw textfield
            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPassordController,
            ),
            const SizedBox(
              height: 25.0,
            ),

            // Register button
            MyButtin(
              text: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25.0,
            ),

            // register now

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Login now',
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
