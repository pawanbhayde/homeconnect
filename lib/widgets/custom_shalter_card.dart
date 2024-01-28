import 'package:flutter/material.dart';

class LatestShelter extends StatelessWidget {
  const LatestShelter({
    super.key,
    required this.title,
    required this.category,
    required this.onPressed,
  });
  final String title;
  final String category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        //navigate to shelter details page  when pressed
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: category == 'Food'
                      ? const AssetImage('assets/images/food.png')
                      : category == 'Clothes'
                          ? const AssetImage('assets/images/cloths.png')
                          : category == 'Education'
                              ? const AssetImage('assets/images/education.png')
                              : category == 'Charity'
                                  ? const AssetImage(
                                      'assets/images/charity.png')
                                  : const AssetImage(
                                      'assets/images/ngo-banner-1.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                  'Category: $category',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
