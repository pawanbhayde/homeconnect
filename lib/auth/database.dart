import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class DatabaseService {
  //insert data into supabase table
  static Future<PostgrestResponse?> addShelter({
    required String name,
    required String address,
    required int phone,
    required String image,
  }) async {
    final data = {
      'name': name,
      'address': address,
      'phone': phone,
      'image': image,
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

  //upload image to supabase storage
  static Future<String?> uploadImage(
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
}
