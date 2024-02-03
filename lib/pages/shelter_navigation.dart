import 'package:flutter/material.dart';
import 'package:helpus/pages/home_page.dart';
import 'package:helpus/pages/profile_page.dart';
import 'package:helpus/pages/searchshelter.dart';
import 'package:iconsax/iconsax.dart';

class ShelterNavigation extends StatefulWidget {
  const ShelterNavigation({Key? key}) : super(key: key);

  @override
  State<ShelterNavigation> createState() => _ShelterNavigationState();
}

class _ShelterNavigationState extends State<ShelterNavigation> {
  int selectedPage = 0;
  final List<Widget> pages = [
    // Add Shelter Detail Page
    const Placeholder(),
    // History Page
    const Placeholder(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          fixedColor: const Color(0xff395EE7),
          unselectedItemColor: const Color(0xFF757575),
          onTap: (position) {
            setState(() {
              selectedPage = position;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.search_normal), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Account")
          ]),
    );
  }
}
