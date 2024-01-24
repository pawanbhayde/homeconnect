import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpus/pages/navigator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? _image;

  // final ImagePicker _imagePicker = ImagePicker();
  // PickedFile? _pickedImage;

  // void _pickImage() async {
  //   final File pickedImage =
  //       (await _imagePicker.pickImage(source: ImageSource.gallery)) as File;
  //   setState(() {
  //     _pickedImage = pickedImage as PickedFile?;
  //   });
  // }

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
                onTap: () async {
                  // Now you can use imagePath as needed.
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
                  child: _image == null
                      ? const Center(
                          child: Icon(
                            Iconsax.gallery_add,
                            size: 40.0,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            _image as File,
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
                    primary: Colors.black,
                    onPrimary: Colors.white,
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

  // Bottom sheet To Pick Profile picture for users
  // void _showBottomSheet() {
  //   showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //       builder: (_) {
  //         return ListView(
  //           shrinkWrap: true,
  //           // padding: EdgeInsets.only(
  //           //     top: size.height * .02, bottom: size.height * .05),
  //           children: [
  //             //Drawer Title
  //             const Text(
  //               "Pick Profile picture",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //             ),
  //
  //             //For adding Some Space
  //             // SizedBox(
  //             //   height: size.height * .02,
  //             // ),
  //
  //             //Drawer Button
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 //Gallery Button
  //
  //                 ElevatedButton.icon(
  //                     style:
  //                         ButtonStyle(iconSize: MaterialStateProperty.all(30)),
  //                     onPressed: () async {
  //                       final ImagePicker picker = ImagePicker();
  //                       final ImageCropper cropper = ImageCropper();
  //
  //                       // Pick an image .
  //                       final XFile? image =
  //                           await picker.pickImage(source: ImageSource.gallery);
  //
  //                       if (image != null) {
  //                         final CroppedFile? crop = await cropper.cropImage(
  //                             sourcePath: image.path,
  //                             aspectRatio:
  //                                 const CropAspectRatio(ratioX: 1, ratioY: 1),
  //                             compressQuality: 100,
  //                             compressFormat: ImageCompressFormat.jpg);
  //                         if (crop != null) {
  //                           setState(() {
  //                             _image = crop.path;
  //                           });
  //                         }
  //
  //                         //for hiding bottom sheet
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     icon: const Icon(Icons.photo),
  //                     label: const Text('Gallery')),
  //
  //                 //Camera Button
  //                 ElevatedButton.icon(
  //                     style:
  //                         ButtonStyle(iconSize: MaterialStateProperty.all(30)),
  //                     onPressed: () async {
  //                       final ImagePicker picker = ImagePicker();
  //                       // Pick an image .
  //                       final XFile? image =
  //                           await picker.pickImage(source: ImageSource.camera);
  //                       if (image != null) {
  //                         setState(() {
  //                           _image = image.path;
  //                         });
  //
  //                         //for hiding bottom sheet
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     icon: const Icon(Icons.photo_camera),
  //                     label: const Text('Camera'))
  //               ],
  //             ),
  //           ],
  //         );
  //       });
  // }
}
