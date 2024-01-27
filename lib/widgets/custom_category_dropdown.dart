import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String?> onCategorySelected;

  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
          border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        value: _selectedCategory,
        hint: const Text('Select Category',
            style: TextStyle(color: Colors.black)),
        items: widget.categories.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (selectedCategory) {
          setState(() {
            _selectedCategory = selectedCategory;
            widget.onCategorySelected(selectedCategory);
          });
        },
      ),
    );
  }
}
