// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:helpus/pages/signin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Authentication {
  //---------------------- Sign Up with email and password
  static Future<void> signUpWithEmail(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String city}) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      // Attempt to sign up the user
      final authResponse =
          await supabase.auth.signUp(email: email, password: password);

      // Check if the sign-up was successful
      if (authResponse.user != null) {
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "Sign Up Successful.",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );

        // store user details in user table
        await DatabaseService.storeUserDetails(
            context, name, email, authResponse.user!.id, '', city);

        // Navigate to the home page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      } else {
        // Display an appropriate error message
        sm.showSnackBar(
          SnackBar(
            content: const Text("Sign-Up failed. Please try again."),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    } catch (error) {
      // Handle specific errors, e.g., if user is already registered
      if (error is AuthException) {
        // for user friendly error message, nested "if"
        if (error.statusCode == 400) {
          sm.showSnackBar(
            SnackBar(
              content: const Text(" User already exists. Please Sign In "),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        } else {
          // Handle other AuthException errors
          sm.showSnackBar(
            SnackBar(
              content: Text(
                " Authentication error: ${error.message}",
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
      } else {
        // Handle other errors
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "An Error Occured",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    }
  }

  //----------- sign up with google
  static Future<void> signUpWithGoogle(BuildContext context) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      // Attempt to sign up the user
      final authResponse = await googleSignIn();

      if (authResponse.user != null) {
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "Sign Up Successful.",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );

        // store user details in user table
        await DatabaseService.storeUserDetails(
          context,
          authResponse.user!.userMetadata?['name'] ?? authResponse.user!.email!,
          authResponse.user!.userMetadata?['email'] ??
              authResponse.user!.email!,
          authResponse.user!.userMetadata?['userid'] ?? authResponse.user!.id,
          authResponse.user!.userMetadata?['avatar_url'] ?? '',
          '',
        );

        // Navigate to the home page
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainNavigation()));
      } else {
        // Display an appropriate error message
        sm.showSnackBar(
          SnackBar(
            content: const Text("Sign-Up failed. Please try again."),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    } catch (error) {
      // Handle specific errors, e.g., if user is already registered
      if (error is AuthException) {
        // for user friendly error message, nested "if"
        if (error.statusCode == 400) {
          sm.showSnackBar(
            SnackBar(
              content: const Text(" User already exists. Please Sign In "),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        } else {
          // Handle other AuthException errors
          sm.showSnackBar(
            SnackBar(
              content: Text(
                " Authentication error: ${error.message}",
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
      } else {
        // Handle other errors
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "An Error Occurred",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    }
  }

  //----------- Sign in with email and password
  static Future<void> signInWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
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
          SnackBar(
            content: const Text(
              "Signed In Successful." /*${authResponse.user!.email!}*/,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainNavigation()));

        // Navigate to the home page
      } else {
        // Display an appropriate error message
        sm.showSnackBar(
          SnackBar(
            content: const Text("Sign-In failed. Please try again."),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    } catch (error) {
      // Handle specific errors, e.g., if user is already registered
      if (error is AuthException) {
        // for user friendly error message, nested "if"
        if (error.statusCode == 400) {
          sm.showSnackBar(
            SnackBar(
              content: const Text(" User not found. Please Sign Up "),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        } else {
          // Handle other AuthException errors
          sm.showSnackBar(
            SnackBar(
              content: Text(
                " Authentication error: ${error.message}",
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
      } else {
        // Handle other errors
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "An Error Occured",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    }
  }

  //------------ Sign In with Google
  static Future<AuthResponse> googleSignIn() async {
    const webClientId =
        '232200069198-pl2uco2rt6q356dbnphrbl3pnv3mmu7g.apps.googleusercontent.com';

    ///
    ///
    /// iOS Client ID that you registered with Google Cloud.
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    try {
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
    } catch (e) {
      print("Error in google sign in: $e");
      throw e;
    }
  }

  //---------- Sign Out
  static Future<void> signOut(BuildContext context) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      // Attempt to sign out the user
      await supabase.auth.signOut();
      // Navigate to the home page
      sm.showSnackBar(
        SnackBar(
          content: const Text("Signed Out Successfully"),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.startToEnd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    } catch (error) {
      // Handle sign out errors
      sm.showSnackBar(
        SnackBar(
          content: const Text(
            "An Error Occured",
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.startToEnd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  //------ get current  user details

  static Future<UserProfile?> getCurrentUser() async {
    // Get the current user ID
    final String userId = supabase.auth.currentUser!.id;

    // Check if user data exists based on Supabase ID
    final supabaseUserData =
        await supabase.from('user').select().eq('userid', userId).single();

    print(" This is Get all user Response:  $supabaseUserData");

    // If user data is found, return directly
    if (supabaseUserData.isNotEmpty) {
      return UserProfile.fromMap(supabaseUserData);
    }

    // If no user data found with Supabase ID, check for Google user
    final String googleUserId =
        supabase.auth.currentUser!.userMetadata?['userid'];
    if (googleUserId.isNotEmpty) {
      final googleUserData = await supabase
          .from('user')
          .select()
          .eq('userid', googleUserId)
          .single();

      // If user data found with Google ID, return it
      if (googleUserData.isNotEmpty) {
        return UserProfile.fromMap(googleUserData);
      }
    }

    // If no user found with both IDs, return null
    return null;
  }
}
