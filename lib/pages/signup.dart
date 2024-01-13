// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:helpus/pages/signin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Sign Up', style: TextStyle(fontSize: 20)),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 3,
            onPressed: () async {
              final sm = ScaffoldMessenger.of(context);

              try {
                // Attempt to sign up the user
                final authResponse = await supabase.auth.signUp(
                  password: passwordController.text,
                  email: emailController.text,
                );

                // Check if the sign-up was successful
                if (authResponse.user != null) {
                  sm.showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Registered Successful, Please Sign In Here" /*${authResponse.user!.email!},*/),
                    ),
                  );

                  // Navigate to sign-in page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                  );
                } else {
                  // Handle other scenarios where user is not registered but sign-up failed
                  sm.showSnackBar(
                    const SnackBar(
                        content: Text("Sign-up failed. Please try again.")),
                  );
                }
              } catch (error) {
                // Handle specific errors, e.g., if user is already registered
                if (error is AuthException) {
                  // for user friendly error message, nested "if"
                  if (error.statusCode == 400) {
                    sm.showSnackBar(
                      const SnackBar(
                        content: Text("User already registered, Sign In"),
                      ),
                    );
                  } else {
                    // Handle other AuthException errors
                    sm.showSnackBar(SnackBar(
                      content: Text("Authentication error: ${error.message}"),
                    ));
                  }
                } else {
                  // Handle other errors
                  sm.showSnackBar(SnackBar(content: Text("Error:$error")));
                }
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
