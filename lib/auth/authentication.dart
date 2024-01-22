// supabase sign in with email and password

import 'package:flutter/material.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Authentication {
  // Sign in with email and password
  static Future<void> signInWithEmail(
      BuildContext context, String email, String password) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      // Attempt to sign up the user
      final authResponse = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainNavigation()));

        // Navigate to the home page
      } else {
        // Display an appropriate error message
        sm.showSnackBar(
          const SnackBar(content: Text("Sign-In failed. Please try again.")),
        );
      }
    } catch (error) {
      // Handle specific errors, e.g., if user is already registered
      if (error is AuthException) {
        // for user friendly error message, nested "if"
        // ignore: unrelated_type_equality_checks
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
  }

  // get current user
}
