// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/utilities/colors.dart';
import 'package:helpus/widgets/custom_category_dropdown.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ShelterSignUp extends StatefulWidget {
  const ShelterSignUp({super.key});

  @override
  State<ShelterSignUp> createState() => _ShelterSignUpState();
}

class _ShelterSignUpState extends State<ShelterSignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: const SizedBox(
            width: 150,
            child: Image(
              image: AssetImage('assets/images/helpus.png'),
              fit: BoxFit.cover,
            )),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                Authentication.signUpShelterWithEmail(
                  context: context,
                  email: emailController.text,
                  password: passwordController.text,
                  name: nameController.text,
                  description: descriptionController.text,
                  category: categoryController.text,
                  street: streetController.text,
                  city: cityController.text.trim(),
                  state: stateController.text.trim(),
                  phone: phoneController.text,
                );
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "An Error Occured",
                    ),
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
            } else {
              //all fields are not filled
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Please fill in all the fields!!'),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Home Shelter Details",
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
                  "Email",
                  style: TextStyle(fontSize: 16),
                ),
                //text field for email
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      //use regex to validate email
                      else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                  "Password",
                  style: TextStyle(fontSize: 16),
                ),
                //text field for password
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password must contain at least one number';
                      } else if (!value
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Password must contain at least one special character';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
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
                  "Home Shelter Name",
                  style: TextStyle(fontSize: 16),
                ),
                //text field for home shelter name
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
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
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number cannot be empty';
                      } else if (value.length < 10) {
                        return 'Phone number must be at least 10 characters long';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: streetController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Street/Area cannot be empty';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'City cannot be empty';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: stateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'State cannot be empty';
                      }
                      return null;
                    },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
