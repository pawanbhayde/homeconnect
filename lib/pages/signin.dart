import 'package:flutter/material.dart';
import 'package:helpus/pages/home_page.dart';
import 'package:helpus/pages/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignInPage extends StatefulWidget {
   SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/flutter_supabase.png', height: 350, width: 400),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Sign In', style: TextStyle(fontSize: 20)),
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
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                      final authResponse =
                          await supabase.auth.signInWithPassword(
                        password: passwordController.text,
                        email: emailController.text,
                      );
                      // Check if the sign-up was successful
                      if (authResponse.user != null) {
                        sm.showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Signed In Successful." /*${authResponse.user!.email!}*/,
                            ),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));

                        // Navigate to the home page
                      } else {
                        // Display an appropriate error message
                        sm.showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Sign-In failed. Please try again.")),
                        );
                      }
                    } catch (error) {
                      // Handle specific errors, e.g., if user is already registered
                      if (error is AuthException) {
                        // for user friendly error message, nested "if"
                        if (error.statusCode == 400) {
                          sm.showSnackBar(
                            const SnackBar(
                              content: Text(" User not found. Please Sign Up "),
                            ),
                          );
                        } else {
                          // Handle other AuthException errors
                          sm.showSnackBar(
                            SnackBar(
                              content: Text(
                                " Authentication error: ${error.message}",
                              ),
                            ),
                          );
                        }
                      } else {
                        // Handle other errors
                        sm.showSnackBar(
                          SnackBar(
                            content: Text(
                              "Error:${error.toString()}",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Sign In'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text('Sign Up'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
