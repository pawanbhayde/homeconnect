import 'package:flutter/material.dart';

class Caller {
  final int id;
  final String name;
  final String email;
  final DateTime date;
  final TimeOfDay time;
  final int shelterId;

  const Caller({
    required this.id,
    required this.name,
    required this.email,
    required this.date,
    required this.time,
    required this.shelterId,
  });

  // Factory method to create a UserRegistration instance from a Map
  factory Caller.fromMap(Map<String, dynamic> json) {
    return Caller(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(":")[0]),
        minute: int.parse(json['time'].split(":")[1]),
      ),
      shelterId: json['shelterId'],
    );
  }

  // Method to convert UserRegistration instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'date': date.toString(),
      'time': '${time.hour}:${time.minute}',
      'shelterId': shelterId,
    };
  }

  @override
  String toString() =>
      'UserRegistration{id:$id, name: $name, email: $email, date: $date, time: $time, shelterId: $shelterId}';
}
