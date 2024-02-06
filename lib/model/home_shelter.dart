class HomeShelter {
  final int id;
  final String email;

  final String name;
  final String description;
  final String category;
  final String street;
  final String city;
  final String state;
  final int phone;
  final String banner;

  const HomeShelter({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.category,
    required this.street,
    required this.city,
    required this.state,
    required this.phone,
    required this.banner,
  });

  // Factory method to create a HomeShelter instance from a Map returned by Supabase
  factory HomeShelter.fromMap(Map<String, dynamic> json) {
    return HomeShelter(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      category: json['category'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      banner: json['banner'],
    );
  }

  // Method to convert HomeShelter instance to a Map for storing in Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'description': description,
      'category': category,
      'street': street,
      'city': city,
      'state': state,
      'phone': phone,
      'banner': banner,
    };
  }

  @override
  String toString() =>
      'HomeShelter{id:$id, email:$email , name: $name, description: $description, '
      'category: $category, street: $street, city: $city, '
      'state: $state, phone: $phone, banner: $banner}';
}
