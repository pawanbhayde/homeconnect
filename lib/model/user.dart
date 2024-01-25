class UserProfile {
  final String name;
  final String email;
  final String location;
  final String profilePicture;
  final String userid;
  UserProfile({
    required this.name,
    required this.email,
    required this.location,
    required this.profilePicture,
    required this.userid,
  });

  // Factory method to create a User instance from a Map returned by Supabase
  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      name: data['name'],
      email: data['email'],
      location: data['location'] ?? '',
      profilePicture: data['profile_picture'] ?? '',
      userid: data['userid'],
    );
  }

  // Method to convert User instance to a Map for storing in Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'location': location,
      'profile_picture': profilePicture,
      'userid': userid,
    };
  }
}
