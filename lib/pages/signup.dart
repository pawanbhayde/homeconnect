// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/pages/city_input_screen.dart';
import 'package:helpus/pages/signin.dart';
import 'package:helpus/utilities/colors.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              // height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/helpus.png', width: 200),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Sign up with Email & Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          //use regex to validate email
                          else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one number';
                          } else if (!value
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password must contain at least one special character';
                          }

                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name cannot be empty';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: cityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City cannot be empty';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: MaterialButton(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () async {
                              //sign up with email and password
                              await Authentication.signUpWithEmail(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                city: cityController.text,
                              );
                              //navigate to main navigation
                            },
                            child: const Text('Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have an Account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()),
                                );
                              },
                              child: const Text('Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    //sign Up with google and apple
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          "Or Continue with",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 135, 135, 135),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //sign up with google
                            await Authentication.signUpWithGoogle(context);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CityInputScreen()),
                            );
                          } else {
                            //all fields are not filled
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    const Text('Please fill in all the fields'),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                showCloseIcon: true,
                                behavior: SnackBarBehavior.floating,
                                dismissDirection: DismissDirection.startToEnd,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffEEF5FF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/google.png'),
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign Up with Google",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
