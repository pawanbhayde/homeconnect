import 'dart:async';

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
}
