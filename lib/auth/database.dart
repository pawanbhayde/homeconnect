import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class DatabaseService {
  //insert data into supabase table
  static Future<PostgrestResponse?> addShelter({
    required String name,
    required String description,
    required int phone,
    required String category,
    required String street,
    required String city,
    required String state,
    //  required CroppedFile crop,
  }) async {
    final data = {
      'name': name,
      'description': description,
      'phone': phone,
      'category': category,
      'street': street,
      'city': city,
      'state': state,
    };

    try {
      PostgrestResponse? response =
          await supabase.from('HomeShelter').insert(data);

      if (response?.data != null) {
        print(response?.data);
      } else {
        print(data);
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  //get stream of data from supabase table
  static SupabaseStreamFilterBuilder getShelter() {
    return supabase.from('HomeShelter').stream(primaryKey: ['id']);
  }

  //--------- store users google sign in details into user table
  static Future<void> storeUserDetails(BuildContext context, String name,
      String email, String id, String profileurl) async {
    final sm = ScaffoldMessenger.of(context);

    try {
      final response = await supabase.from('user').insert([
        {
          'userid': id,
          'name': name,
          'email': email,
          'profile_picture': profileurl,
        }
      ]);

      if (response.error == null) {
        sm.showSnackBar(
          const SnackBar(
            content: Text("User Details Stored Successfully"),
          ),
        );
      } else {
        sm.showSnackBar(
          SnackBar(
            content: Text(
              "Error storing user details: ${response.error!.message}",
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
}
