import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CityInputScreen extends StatefulWidget {
  const CityInputScreen({super.key});

  @override
  _CityInputScreenState createState() => _CityInputScreenState();
}

class _CityInputScreenState extends State<CityInputScreen> {
  final TextEditingController cityController = TextEditingController();
  //final user = Supabase.instance.client.auth.currentUser;
  final String? email = Supabase.instance.client.auth.currentUser!.email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Enter your city'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: cityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Store the city in your database
                    // For example, if you're using Supabase, you can do:
                    print(email);
                    try {
                      // await supabase.from('user').update(
                      //     {'city': cityController.text}).match({'email': email});

                      final response = await supabase
                          .from('user')
                          .update({'city': cityController.text}).match(
                              {'email': email});
                      print(response);

                      //show snackbar if city is updated

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('City updated successfully'),
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

                      // Navigate to the home page
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainNavigation()));
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    //all fields are not filled
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill in all the fields'),
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
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
