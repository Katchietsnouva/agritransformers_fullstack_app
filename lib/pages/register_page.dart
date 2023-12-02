import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //TextEditingController
  final emailController = TextEditingController();
  final passworController = TextEditingController();
  final confirmPassworController = TextEditingController();

  // Sign up User
  void signUp() async {
    if (passworController.text != confirmPassworController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password do not match!'),
        ),
      );
      return;
    }

    //Get Auth service if the above are good
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
        emailController.text,
        passworController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    //Logo
                    Icon(
                      Icons.message,
                      size: 100,
                      color: Colors.grey[800],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'AgriTransformers Chat Module',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    //Lets create an account for you
                    const Text(
                      'Lets create an account for you',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    //email Textfield
                    MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false),

                    const SizedBox(height: 25),

                    //password Textfield
                    MyTextField(
                        controller: passworController,
                        hintText: 'Password',
                        obscureText: true),

                    const SizedBox(height: 25),

                    //Confirm password Textfield
                    MyTextField(
                        controller: confirmPassworController,
                        hintText: 'Confirm Password',
                        obscureText: true),

                    const SizedBox(height: 25),

                    //Sign Up button
                    MyButton(onTap: signUp, text: 'Sign Up'),

                    const SizedBox(height: 25),

                    // Already a member? Login now

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('Already a member?'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
