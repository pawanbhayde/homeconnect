import 'package:flutter/material.dart';

class ShelterHomePage extends StatefulWidget {
  const ShelterHomePage({
    super.key,
    required this.title,
    required this.id,
    required this.category,
    required this.phone,
    required this.email,
    required this.description,
    required this.street,
    required this.city,
    required this.state,
    required this.banner,
  });

  final int id;
  final String title;
  final String category;
  final int phone;
  final String email;
  final String description;
  final String street;
  final String city;
  final String state;
  final String banner;

  @override
  State<ShelterHomePage> createState() => _ShelterHomePageState();
}

class _ShelterHomePageState extends State<ShelterHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Color(0xffF3F2F5),
                image: DecorationImage(
                  image: AssetImage('assets/images/home.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Home Shelter Name
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Home Shelter Address
                  Text(
                    //address of the shelter
                    widget.street + ', ' + widget.city + ', ' + widget.state,

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Home Shelter Category
                  Text(
                    'Category: ' + widget.category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Home Shelter Phone
                  Text(
                    'Phone: ' + widget.phone.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Home Shelter Email
                  Text(
                    'Email: ' + widget.email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Home Shelter Description
                  const Text(
                    'Description: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
