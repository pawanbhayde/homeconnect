// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/model/home_shelter.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/pages/user_navigator.dart';
import 'package:helpus/pages/sheltersignin.dart';
import 'package:helpus/pages/signin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Authentication {
  //========= User Authentication =========

  //------- Sign Up User with email and password
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

        // After successful signup, insert into userType table
        final typedata = {
          'email': email,
          'user_type': 'user',
        };
        final typeresponse = await supabase.from('userType').insert(typedata);

        print(typeresponse);

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

  //----------- sign up User with google
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

        // After successful signup, insert into userType table
        await supabase.from('userType').insert([
          {
            'email': authResponse.user!.userMetadata?['email'] ??
                authResponse.user!.email!,
            'user_type': 'user',
          }
        ]);

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
            MaterialPageRoute(builder: (context) => const UserNavigation()));
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

  //----------- Sign in User with email and password
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
            MaterialPageRoute(builder: (context) => const UserNavigation()));

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

  //------------ Sign In User with Google
  static Future<AuthResponse> googleSignIn() async {
    const webClientId =
        '232200069198-pl2uco2rt6q356dbnphrbl3pnv3mmu7g.apps.googleusercontent.com';

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

  //------ get current user details

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

  //========= HomeShelter Authentication =========

  //----------- Sign Up Shelter with email and password
  static Future<void> signUpShelterWithEmail({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String description,
    required String category,
    required String street,
    required String city,
    required String state,
    required String phone,
  }) async {
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
        // After successful signup, insert into userType table
        final typedata = {
          'email': email,
          'user_type': 'shelter',
        };
        final typeresponse = await supabase.from('userType').insert(typedata);

        print(typeresponse);

        // store shelter details in Home shelter table
        await DatabaseService.storeShelterDetails(
            email: email,
            name: name,
            description: description,
            category: category,
            street: street,
            city: city,
            state: state,
            phone: int.parse(phone),
            banner: '',
            context: context);

        // Navigate to the home page

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShelterSignInPage()));
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
  }

  //get current shelter details from supabase table
  static Future<HomeShelter?> getCurrentShelterDetails(String? email) async {
    final response = await supabase
        .from('HomeShelter')
        .select()
        .eq('email', email!)
        .single();

    if (response.isNotEmpty) {
      final shelter = HomeShelter.fromMap(response);
      return shelter;
    } else {
      throw Exception('Shelter not found');
    }
  }
}
