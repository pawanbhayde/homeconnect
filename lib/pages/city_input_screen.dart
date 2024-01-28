import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CityInputScreen extends StatefulWidget {
  @override
  _CityInputScreenState createState() => _CityInputScreenState();
}

class _CityInputScreenState extends State<CityInputScreen> {
  final TextEditingController cityController = TextEditingController();
  //final user = Supabase.instance.client.auth.currentUser;
  final String? email = Supabase.instance.client.auth.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Enter your city'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Store the city in your database
                // For example, if you're using Supabase, you can do:
                print(email);
                try {
                  // await supabase.from('user').update(
                  //     {'city': cityController.text}).match({'email': email});

                  final response = await supabase.from('user').update(
                      {'city': cityController.text}).match({'email': email});
                  print(response);

                  //show snackbar if city is updated
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('City updated successfully'),
                    ),
                  );

                  // Navigate to the home page
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainNavigation()));
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
