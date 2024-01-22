import 'package:flutter/material.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/pages/navigator.dart';

class AddHomeShelter extends StatefulWidget {
  const AddHomeShelter({super.key});

  @override
  State<AddHomeShelter> createState() => _AddHomeShelterState();
}

class _AddHomeShelterState extends State<AddHomeShelter> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController coverController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
            width: 100,
            child: Image(
              image: AssetImage('assets/images/helpus.png'),
              fit: BoxFit.cover,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Home Shelter",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Please fill in the form below to add a new home shelter.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Home Shelter Name",
                style: TextStyle(fontSize: 16),
              ),
              //text field for home shelter name
              SizedBox(
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Address",
                style: TextStyle(fontSize: 16),
              ),
              //text field for address
              SizedBox(
                height: 50,
                child: TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Phone Number",
                style: TextStyle(fontSize: 16),
              ),
              //text field for phone number
              SizedBox(
                height: 50,
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Cover Image",
                style: TextStyle(fontSize: 16),
              ),

              //text field for cover image
              SizedBox(
                height: 50,
                child: TextField(
                  controller: coverController,
                  decoration: const InputDecoration(
                    enabled: true,
                    labelText: 'Cover Image URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await DatabaseService.addShelter(
                        name: nameController.text,
                        address: addressController.text,
                        phone: int.parse(phoneController.text),
                        image: coverController.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainNavigation();
                          },
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFEB61D),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
