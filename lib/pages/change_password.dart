// import 'package:flutter/material.dart';
// import 'package:helpus/utilities/colors.dart';
//
// class ChangePasswod extends StatelessWidget {
//   const ChangePasswod({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.35,
//               color: const Color(0xffF3F2F5),
//               child: Center(
//                 child: Container(
//                   width: 100,
//                   height: 100,AZ
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: const DecorationImage(
//                       image: AssetImage('assets/images/logo.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Text('Change Password',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   const SizedBox(height: 20),
//                   Text('Please enter your old password and new password',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       )),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Old Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'New Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Change Password',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
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
  //   //get the current password before changing it
  //
  //   if (_formKey.currentState!.validate()) {
  //     if (_newPasswordController.text == _confirmPasswordController.text) {
  //       final userAttributes =
  //           UserAttributes(password: _newPasswordController.text);
  //       final response =
  //           await Supabase.instance.client.auth.updateUser(userAttributes);
  //
  //       if (response.user != null) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Password changed successfully')),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Error changing password: $response')),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Passwords do not match')),
  //       );
  //     }
  //   }
  // }
  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Current password verified, proceed with update
        final userAttributes =
            UserAttributes(password: _newPasswordController.text);
        final response = await supabase.auth.updateUser(userAttributes);

        if (response.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully')),
          );

          Navigator.pop(context);

          // Consider signing out or prompting for re-authentication
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error changing password: $response')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid current password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildPasswordFields(),
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _currentPasswordController,
            decoration: const InputDecoration(
              labelText: 'Current Password',
            ),
            // Add validation for current password
          ),
          TextFormField(
            controller: _newPasswordController,
            decoration: const InputDecoration(
              labelText: 'New Password',
            ),
            // Add validation for new password
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirm New Password',
            ),
            // Add validation for confirm password
          ),
          ElevatedButton(
            onPressed: _changePassword,
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
