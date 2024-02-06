// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/utilities/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswod extends StatefulWidget {
  const ChangePasswod({Key? key}) : super(key: key);

  @override
  State<ChangePasswod> createState() => _ChangePasswodState();
}

class _ChangePasswodState extends State<ChangePasswod> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final supabase = Supabase.instance.client;
  String? userId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    final user = supabase.auth.currentUser!;
    setState(() {
      userId = user.id;
    });
  }

  // void _changePassword() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       // Current password verified, proceed with update
  //       final userAttributes =
  //           UserAttributes(password: _newPasswordController.text);
  //       final response = await supabase.auth.updateUser(userAttributes);
  //
  //       if (response.user != null) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: const Text('Password changed successfully'),
  //             margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             showCloseIcon: true,
  //             behavior: SnackBarBehavior.floating,
  //             dismissDirection: DismissDirection.startToEnd,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //           ),
  //         );
  //
  //         Navigator.pop(context);
  //
  //         // Consider signing out or prompting for re-authentication
  //         Authentication.signOut(context);
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Error changing password: $response'),
  //             margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             showCloseIcon: true,
  //             behavior: SnackBarBehavior.floating,
  //             dismissDirection: DismissDirection.startToEnd,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text('Invalid current password'),
  //           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           showCloseIcon: true,
  //           behavior: SnackBarBehavior.floating,
  //           dismissDirection: DismissDirection.startToEnd,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }

  void _changePassword() async {
    final user = supabase.auth.currentSession?.providerToken;
    if (user == 'google') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'You are logged in with Google. Please change your password through Google\'s account management page.'),
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
      if (_formKey.currentState!.validate()) {
        try {
          // Current password verified, proceed with update
          final userAttributes =
              UserAttributes(password: _newPasswordController.text);
          final response = await supabase.auth.updateUser(userAttributes);

          if (response.user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Password changed successfully'),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.startToEnd,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );

            Navigator.pop(context);

            // Consider signing out or prompting for re-authentication
            Authentication.signOut(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error changing password: $response'),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Invalid current password'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xffF3F2F5),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: _changePassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Change Password',
              style: TextStyle(color: Colors.white)),
        ),
      ),
      body: _buildPasswordFields(),
    );
  }

  Widget _buildPasswordFields() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: const Color(0xffF3F2F5),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Please enter your old password and new password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Add validation for current password
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Add validation for new password
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Add validation for confirm password
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
