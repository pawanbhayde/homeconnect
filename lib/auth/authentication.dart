// supabase sign in with email and password

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  // Sign Out
  static Future<void> signOut(BuildContext context) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      // Attempt to sign out the user
      await supabase.auth.signOut();
      // Navigate to the home page
      sm.showSnackBar(
        const SnackBar(
          content: Text("Signed Out Successfully"),
        ),
      );
    } catch (error) {
      // Handle sign out errors
      sm.showSnackBar(
        SnackBar(
          padding: EdgeInsets.only(bottom: 10),
          content: Text(
            "Error signing out: ${error.toString()}",
          ),
        ),
      );
    }
  }

  // Sign in with Google
  static Future<AuthResponse> googleSignIn() async {
    const webClientId =
        '232200069198-pl2uco2rt6q356dbnphrbl3pnv3mmu7g.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
