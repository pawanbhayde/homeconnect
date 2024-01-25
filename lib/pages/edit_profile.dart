import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() {
    return EditProfileScreenState();
  }
}

class EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  PickedFile? pickedImage;

  pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final ImageCropper cropper = ImageCropper();

    showBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .02,
                bottom: MediaQuery.of(context).size.height * .05),
            children: [
              const Text(
                'Pick Profile picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick image from gallery
                  ElevatedButton.icon(
                      style:
                          ButtonStyle(iconSize: MaterialStateProperty.all(30)),
                      onPressed: () async {
                        final ImageCropper cropper = ImageCropper();

                        // Pick an image .
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          final CroppedFile? crop = await cropper.cropImage(
                              sourcePath: image.path,
                              aspectRatio:
                                  const CropAspectRatio(ratioX: 1, ratioY: 1),
                              compressQuality: 100,
                              compressFormat: ImageCompressFormat.jpg);

                          try {
                            if (crop != null) {
                              photo = crop.path;

                              //update the profile picture

                              //for hiding bottom sheet
                              Navigator.pop(context);

                              //Show AlertDialog after successful update
                            }
                          } catch (e) {
                            //show snakbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Failed to update profile picture'),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('Gallery')),
                  //pick image from camera
                  ElevatedButton.icon(
                    style: ButtonStyle(iconSize: MaterialStateProperty.all(30)),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image .
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        final CroppedFile? crop = await cropper.cropImage(
                            sourcePath: image.path,
                            aspectRatio:
                                const CropAspectRatio(ratioX: 1, ratioY: 1),
                            compressQuality: 100,
                            compressFormat: ImageCompressFormat.jpg);
                        if (crop != null) {
                          photo = crop.path;

                          //update the profile picture

                          //for hiding bottom sheet
                          Navigator.pop(context);

                          //Show AlertDialog after successful update
                        }
                      }
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Camera'),
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              GestureDetector(
                onTap: () {
                  pickImage(context);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: pickedImage == null
                      ? const Center(
                          child: Icon(
                            Iconsax.profile_add,
                            size: 40.0,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            pickedImage!.path as File,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 50.0),

              // Name TextField
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 10.0),

              // Email TextField
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 50.0),

              // Update Profile Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MainNavigation();
                        },
                      ),
                    );
                  },
                  child: const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
