import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/model/home_shelter.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/utilities/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeShelterDetails extends StatefulWidget {
  const HomeShelterDetails({
    super.key,
    required this.title,
    required this.id,
    required this.category,
    required this.phone,
  });

  final int id;
  final String title;
  final String category;
  final int phone;

  @override
  State<HomeShelterDetails> createState() => _HomeShelterDetailsState();
}

class _HomeShelterDetailsState extends State<HomeShelterDetails> {
  HomeShelter? shelterDetails;
  UserProfile? user;

  @override
  void initState() {
    super.initState();

    DatabaseService.getShelterDetails(widget.id).then((value) {
      setState(() {
        shelterDetails = value;
        print(shelterDetails);
      });
    });

    // get user details
    Authentication.getCurrentUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Shelter Details'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () async {
            await DatabaseService.storeCallerDetails(
              name: user!.name,
              email: user!.email,
              date: DateTime.now(),
              time: TimeOfDay.now(),
              shelterId: widget.id,
            );

            launch("tel://${widget.phone}");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Call Us',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: DatabaseService.getShelterDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Your existing builder code
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          // topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: widget.category == 'Food'
                              ? const AssetImage('assets/images/food.png')
                              : widget.category == 'Clothes'
                                  ? const AssetImage('assets/images/cloths.png')
                                  : widget.category == 'Education'
                                      ? const AssetImage(
                                          'assets/images/education.png')
                                      : widget.category == 'Charity'
                                          ? const AssetImage(
                                              'assets/images/charity.png')
                                          : const AssetImage(
                                              'assets/images/ngo-banner-1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      shelterDetails!.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${shelterDetails!.street},${shelterDetails!.city},${shelterDetails!.state}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      shelterDetails!.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    // Amenities
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F2F5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        shelterDetails!.category,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
