import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/pages/change_password.dart';
import 'package:helpus/pages/help&support.dart';
import 'package:helpus/pages/splash_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? profile;
  late final supabase = Supabase.instance.client;
  StreamSubscription? subscription;

  pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final ImageCropper cropper = ImageCropper();
    showBottomSheet(
        backgroundColor: const Color(0xffF3F2F5),
        // const Color(0xff395EE7),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff395EE7),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick image from gallery
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        iconColor: MaterialStateProperty.all(Colors.white),
                        iconSize: MaterialStateProperty.all(25),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff395EE7))),
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
                            // Upload cropped image to Supabase storage

                            final imageExtension =
                                crop.path.split('.').last.toLowerCase();

                            final data = await DatabaseService.uploadImage(
                              filePath: crop.path,
                              storagePath: '/${profile!.userid}/profile',
                              imageExtension: imageExtension,
                            );

                            print('Print on Profile Screen : $data');

                            // Close bottom sheet
                            Navigator.pop(context);

                            // Show AlertDialog after successful update
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Success'),
                                  content: const Text(
                                      'Profile picture updated successfully'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        } catch (e) {
                          //show snakbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to update profile picture'),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //pick image from camera
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        iconColor: MaterialStateProperty.all(Colors.white),
                        iconSize: MaterialStateProperty.all(25),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff395EE7))),
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

                        try {
                          if (crop != null) {
                            // Upload cropped image to Supabase storage

                            final imageExtension =
                                crop.path.split('.').last.toLowerCase();

                            final data = await DatabaseService.uploadImage(
                              filePath: crop.path,
                              storagePath: '/${profile!.userid}/profile',
                              imageExtension: imageExtension,
                            );

                            print('Print on Profile Screen : $data');

                            // Close bottom sheet
                            Navigator.pop(context);

                            // Show AlertDialog after successful update
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Success'),
                                  content: const Text(
                                      'Profile picture updated successfully'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        } catch (e) {
                          //show snakbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to update profile picture'),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    // Get user profile
    Authentication.getCurrentUser().then((value) => setState(() {
          profile = value;
        }));
  }

  @override
  void dispose() {
    super.dispose();
    // Unsubscribe from realtime updates
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Out'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This will sign you out of the app'),
                  Text('Are you sure?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Logout'),
                onPressed: () async {
                  await Authentication.signOut(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (route) => false);
                },
              ),
            ],
          );
        },
      );
    }

    return StreamBuilder<Object>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You are not logged in',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          // AppBar
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xffF3F2F5),
            title: const SizedBox(
                width: 150,
                child: Image(
                  image: AssetImage('assets/images/helpus.png'),
                  fit: BoxFit.cover,
                )),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    showMyDialog();
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.black),
                ),
              )
            ],
          ),

          // Body
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xffF3F2F5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Stack(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: profile?.profilePicture == null
                                    ? const Icon(
                                        Iconsax.user,
                                        size: 50,
                                      )
                                    : Image.network(
                                        profile!.profilePicture,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  pickImage(context);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: const Color(0xff395EE7),
                                  ),
                                  child: const Icon(
                                    color: Colors.white,
                                    Iconsax.edit,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          profile?.name ?? 'user name',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profile?.email ?? 'user email',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            showMyDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.0, color: Colors.black),
                            backgroundColor: const Color(0xffF3F2F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(100, 40),
                          ),
                          child: const Text('Logout',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Custom_Profile_Item(
                    title: 'Setting',
                    icon: Iconsax.setting,
                    onPressed: () {},
                  ),
                  Custom_Profile_Item(
                    title: 'Change Password',
                    icon: Iconsax.lock,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ChangePasswod();
                          },
                        ),
                      );
                    },
                  ),
                  Custom_Profile_Item(
                    title: 'Help & Support',
                    icon: Iconsax.support,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HelpAndSupport();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Custom_Profile_Item extends StatelessWidget {
  const Custom_Profile_Item({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xffF3F2F5),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Icon(
                Iconsax.arrow_right_3,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
