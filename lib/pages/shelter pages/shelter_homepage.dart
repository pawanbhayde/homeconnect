import 'package:flutter/material.dart';
import 'package:helpus/auth/database.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ShelterHomePage extends StatefulWidget {
  const ShelterHomePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<ShelterHomePage> createState() => _ShelterHomePageState();
}

class _ShelterHomePageState extends State<ShelterHomePage> {
  pickImage(BuildContext context, {required userId, required shelterId}) async {
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

                            print(imageExtension);

                            final data =
                                await DatabaseService.uploadShelterBanner(
                              shelterId: shelterId,
                              filePath: crop.path,
                              storagePath: '/$userId/banner',
                              imageExtension: imageExtension,
                            );

                            print('Print on Profile Screen : $data');

                            // Close bottom sheet
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);

                            // Show AlertDialog after successful update
                            // ignore: use_build_context_synchronously
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
                          print(e.toString());
                          //show snakbar

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Failed to update profile picture'),
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

                            final data =
                                await DatabaseService.uploadShelterBanner(
                              shelterId: shelterId,
                              filePath: crop.path,
                              storagePath: '/$userId/banner',
                              imageExtension: imageExtension,
                            );

                            print('Print on Profile Screen : $data');

                            // Close bottom sheet
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);

                            // Show AlertDialog after successful update
                            // ignore: use_build_context_synchronously
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
                          print(e.toString());
                          //show snakbar
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Failed to update profile picture'),
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
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService.getShelterStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final event = snapshot.data;
            // Use the event to update the UI.
            final filteredData = (snapshot.data as List)
                .where((element) => element['id'] == widget.id)
                .toList();

            print(filteredData);

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Home Shelter Name
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: filteredData[0]['banner'] == null ||
                                    filteredData[0]['banner'] == ''
                                ? Container(
                                    color: const Color(0xffF3F2F5),
                                    child: const Icon(
                                      Iconsax.gallery_add,
                                      size: 50,
                                    ),
                                  )
                                : Image.network(
                                    filteredData[0]['banner'],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              pickImage(
                                shelterId: filteredData[0]['id'],
                                context,
                                userId: supabase.auth.currentUser!.id,
                              );
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

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredData[0]['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Home Shelter Address
                          Text(
                            //address of the shelter
                            filteredData[0]['street'] +
                                ', ' +
                                filteredData[0]['city'] +
                                ', ' +
                                filteredData[0]['state'],

                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Home Shelter Category
                          Text(
                            'Category: ${filteredData[0]['category']} ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 10),
                          // Home Shelter Phone
                          Text(
                            'Phone: ${filteredData[0]['phone'].toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Home Shelter Email
                          Text(
                            'Email: ${filteredData[0]['email']} ',
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
                            filteredData[0]['description'],
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

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
