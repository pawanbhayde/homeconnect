import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:helpus/model/home_shelter.dart';

class NeedFirstBox extends StatelessWidget {
  HomeShelter? shelterDetails;
  NeedFirstBox({
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: 300,
        decoration: BoxDecoration(
          // show image based on the category of the shelter

          image: DecorationImage(
            image: category == 'Food'
                ? const AssetImage('assets/images/food.png')
                : category == 'Clothes'
                    ? const AssetImage('assets/images/cloths.png')
                    : category == 'Education'
                        ? const AssetImage('assets/images/education.png')
                        : category == 'Charity'
                            ? const AssetImage('assets/images/charity.png')
                            : const AssetImage(
                                'assets/images/ngo-banner-1.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          //
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ).asGlass(
              tintColor: Colors.black.withOpacity(0.2),
              clipBorderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
