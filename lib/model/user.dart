class UserProfile {
  final String id;
  final String name;
  final String email;
  final String location;
  final String profilePicture;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    required this.profilePicture,
  });

  // Factory method to create a User instance from a Map returned by Supabase
  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      location: data['location'],
      profilePicture: data['profile_picture'],
    );
  }

  // Method to convert User instance to a Map for storing in Supabase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'profile_picture': profilePicture,
    };
  }
}
