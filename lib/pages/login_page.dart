import 'package:flutter/material.dart';
import 'package:helpus/pages/shelter%20pages/sheltersignin.dart';
import 'package:helpus/pages/userPages/signin.dart';
import 'package:helpus/utilities/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: const Image(
                    image: AssetImage('assets/images/bg2.png'),
                    fit: BoxFit.cover)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignInPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Login as a User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ShelterSignInPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Login as a Shelter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Text(
                'HomeConnect: Empowering Hope, Building Homes for the Homeless.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
