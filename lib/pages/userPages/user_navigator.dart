import 'package:flutter/material.dart';
import 'package:helpus/pages/userPages/home_page.dart';
import 'package:helpus/pages/userPages/profile_page.dart';
import 'package:helpus/pages/userPages/searchshelter.dart';
import 'package:iconsax/iconsax.dart';

class UserNavigation extends StatefulWidget {
  const UserNavigation({Key? key}) : super(key: key);

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  int selectedPage = 0;
  final List<Widget> pages = [
    const HomePage(),
    const SearchHomeShelter(),
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
