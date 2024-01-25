import 'package:flutter/material.dart';
import 'package:helpus/pages/login_page.dart';
import 'package:helpus/utilities/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: const Image(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover)),
            const SizedBox(
              height: 80,
            ),
            const SizedBox(
                width: 200,
                child: Image(
                  image: AssetImage('assets/images/helpus.png'),
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
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
                  "Get Started",
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
                  'HelpUs: Building Homes, Restoring Hope - A Shelter App for the Homeless',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
            ),
          ],
        ));
  }
}
