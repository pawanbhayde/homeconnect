// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpus/model/home_shelter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class DatabaseService {
  //get stream of data from supabase table
  static SupabaseStreamFilterBuilder getShelterStream() {
    return supabase.from('HomeShelter').stream(primaryKey: ['id']);
  }

  //get stream of data for caller from supabase table
  static SupabaseStreamFilterBuilder getCallerStream() {
    return supabase.from('caller').stream(primaryKey: ['id']);
  }

  //get shelter details from supabase table
  static Future<HomeShelter> getShelterDetails(int id) async {
    final response =
        await supabase.from('HomeShelter').select().eq('id', id).single();
    print(response);

    if (response.isNotEmpty) {
      final shelter = HomeShelter.fromMap(response);
      return shelter;
    } else {
      throw Exception('Shelter not found');
    }
  }

  //==========User Details Storage================

  //--------- store users google sign in details into user table
  static Future<void> storeUserDetails(BuildContext context, String name,
      String email, String id, String profileurl, String city) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      final response = await supabase.from('user').insert([
        {
          'userid': id,
          'name': name,
          'email': email,
          'profile_picture': profileurl,
          'city': city,
        }
      ]);

      if (response.error == null) {
        sm.showSnackBar(
          SnackBar(
            content: const Text("User Details Stored Successfully"),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      } else {
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "Error storing user details",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  //upload User Profile picture to supabase storage
  static Future<String?> uploadUserProfile(
      {required String filePath,
      required String storagePath,
      required String imageExtension}) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final String userId = supabase.auth.currentUser!.id;

    // Upload image to Supabase storage

    await supabase.storage.from('profile-picture').uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$imageExtension',
          ),
        );

    // Get uploaded image URL
    String urlResponse = await supabase.storage
        .from('profile-picture')
        .getPublicUrl(storagePath);

    urlResponse = Uri.parse(urlResponse).replace(queryParameters: {
      't': DateTime.now().millisecondsSinceEpoch.toString()
    }).toString();

    //update image url to supabase table
    await supabase
        .from('user')
        .update({'profile_picture': urlResponse}).eq('userid', userId);

    return urlResponse;
  }

  //========Home Shelter Details Storage================

  //store shelter details into supabase table
  static Future<PostgrestResponse?> storeShelterDetails({
    required String email,
    required String name,
    required String description,
    required int phone,
    required String category,
    required String street,
    required String city,
    required String state,
    required String banner,
    required BuildContext context,
    //  required CroppedFile crop,
  }) async {
    final data = {
      'email': email,
      'name': name,
      'description': description,
      'phone': phone,
      'category': category,
      'street': street,
      'city': city,
      'state': state,
      'banner': banner,
    };

    final sm = ScaffoldMessenger.of(context);

    try {
      final response = await supabase.from('HomeShelter').insert(data);

      print(response);

      if (response.error == null) {
        sm.showSnackBar(
          SnackBar(
            content: const Text("Shelter Details Stored Successfully"),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      } else {
        sm.showSnackBar(
          SnackBar(
            content: const Text(
              "Error storing shelter details",
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.startToEnd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  //upload Shelter Banner image to supabase storage
  static Future<String?> uploadShelterBanner({
    required String filePath,
    required String storagePath,
    required String imageExtension,
    required String shelterName,
  }) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();

    // Upload image to Supabase storage

    await supabase.storage.from('shelter-banner').uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$imageExtension',
          ),
        );

    // Get uploaded image URL
    String urlResponse =
        await supabase.storage.from('shelter-banner').getPublicUrl(storagePath);

    urlResponse = Uri.parse(urlResponse).replace(queryParameters: {
      't': DateTime.now().millisecondsSinceEpoch.toString()
    }).toString();

    //update image url to supabase table
    await supabase
        .from('HomeShelter')
        .update({'bannerImage': urlResponse}).eq('id', shelterName);

    return urlResponse;
  }

  //store caller details into supabase table
  static Future<PostgrestResponse?> storeCallerDetails({
    required String name,
    required String email,
    required DateTime date,
    required TimeOfDay time,
    required int shelterId,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'date': date.toString(),
      'time': '${time.hour}:${time.minute}',
      'shelterId': shelterId,
    };

    try {
      final response = await supabase.from('caller').insert(data);

      print(response);

      if (response.error == null) {
        print("Caller Details Stored Successfully");
      } else {
        print("Error storing caller details");
      }
    } catch (error) {
      print('This is error from storeCallerDetails $error');
    }

    return null;
  }
}
