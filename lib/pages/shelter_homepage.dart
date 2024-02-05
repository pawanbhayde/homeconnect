import 'package:flutter/material.dart';

class ShelterHomePage extends StatefulWidget {
  const ShelterHomePage({super.key});

  @override
  State<ShelterHomePage> createState() => _ShelterHomePageState();
}

class _ShelterHomePageState extends State<ShelterHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eco Rustic Style Bali House',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Home Shelter Address
                Text(
                  'Jl. Raya Kedewatan, Kedewatan, Ubud, Kabupaten Gianyar, Bali 80571',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                // Home Shelter Category
                Text(
                  'Category: Food',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),
                // Home Shelter Phone
                Text(
                  'Phone: +62 361 977484',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Home Shelter Email
                Text(
                  'Email: demo@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Home Shelter Description
                Text(
                  'Description: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "This is a description of the shelter. It is a place where people can come and get food and shelter. It is a safe place for people to come and get help. It is a place where people can come and get food and shelter. It is a safe place for people to come and get help. ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
