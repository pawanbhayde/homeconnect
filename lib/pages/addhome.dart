import 'package:flutter/material.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:helpus/utilities/colors.dart';
import 'package:helpus/widgets/custom_category_dropdown.dart';
import 'package:image_cropper/image_cropper.dart';

class AddHomeShelter extends StatefulWidget {
  const AddHomeShelter({super.key});

  @override
  State<AddHomeShelter> createState() => _AddHomeShelterState();
}

class _AddHomeShelterState extends State<AddHomeShelter> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  late final CroppedFile image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const SizedBox(
            width: 150,
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
                "Home Shelter Description",
                style: TextStyle(fontSize: 16),
              ),
              //text field for home shelter name
              SizedBox(
                height: 50,
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
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
                "Home Shelter Category",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              // Add the category dropdown
              CategoryDropdown(
                categories: const ['Food', 'Clothes', 'Charity', 'Education'],
                onCategorySelected: (selectedCategory) {
                  setState(() {
                    categoryController.text = selectedCategory!;
                  });
                },
              ),

              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Street/Area",
                style: TextStyle(fontSize: 16),
              ),
              //text field for address
              SizedBox(
                height: 50,
                child: TextField(
                  controller: streetController,
                  decoration: const InputDecoration(
                    labelText: 'Street/Area',
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
                "City",
                style: TextStyle(fontSize: 16),
              ),
              //text field for address
              SizedBox(
                height: 50,
                child: TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
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
                "State",
                style: TextStyle(fontSize: 16),
              ),
              //text field for address
              SizedBox(
                height: 50,
                child: TextField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'State',
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
                        description: descriptionController.text,
                        category: categoryController.text,
                        street: streetController.text,
                        city: cityController.text,
                        state: stateController.text,
                        phone: int.parse(phoneController.text),
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
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255),
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
