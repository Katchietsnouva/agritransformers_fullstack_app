import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
// import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextEditingController
  final emailController = TextEditingController();
  final passworController = TextEditingController();

  // Sign up User
  Future<void> signIn() async {
    //get auth service

    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await authService.signInWithEmailAndPassword(emailController.text, passworController.text);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);
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
                      Icons.message_outlined,
                      size: 100,
                      color: Colors.grey[800],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Agri-Transformers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    //Welcome back
                    const Text(
                      'Welcome back, you have been missed ',
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

                    //Sign In button
                    MyButton(onTap: signIn, text: 'Sign In'),

                    const SizedBox(height: 25),

                    // Not a member? Register

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('Not a member?'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
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
