class UserProfile {
  final String name;
  final String email;
  final String city;
  final String profilePicture;
  final String userid;
  UserProfile({
    required this.name,
    required this.email,
    required this.city,
    required this.profilePicture,
    required this.userid,
  });

  // Factory method to create a User instance from a Map returned by Supabase
  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      name: data['name'],
      email: data['email'],
      city: data['city'] ?? '',
      profilePicture: data['profile_picture'] ?? '',
      userid: data['userid'],
    );
  }

  // Method to convert User instance to a Map for storing in Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'city': city,
      'profile_picture': profilePicture,
      'userid': userid,
    };
  }
}
