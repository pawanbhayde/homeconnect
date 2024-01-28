class HomeShelter {
  final int id;
  final String name;
  final String description;
  final String category;
  final String street;
  final String city;
  final String state;
  final int phone;

  const HomeShelter({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.street,
    required this.city,
    required this.state,
    required this.phone,
  });

  // Factory method to create a HomeShelter instance from a Map returned by Supabase
  factory HomeShelter.fromMap(Map<String, dynamic> json) {
    return HomeShelter(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      category: json['category'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
    );
  }

  // Method to convert HomeShelter instance to a Map for storing in Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'street': street,
      'city': city,
      'state': state,
      'phone': phone,
    };
  }

  @override
  String toString() =>
      'HomeShelter{id:$id, name: $name, description: $description, '
      'category: $category, street: $street, city: $city, '
      'state: $state, phone: $phone}';
}
