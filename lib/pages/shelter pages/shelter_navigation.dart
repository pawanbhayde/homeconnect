import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/model/home_shelter.dart';
import 'package:helpus/pages/shelter%20pages/historypage.dart';
import 'package:helpus/pages/shelter%20pages/shelter_homepage.dart';
import 'package:iconsax/iconsax.dart';

class ShelterNavigation extends StatefulWidget {
  const ShelterNavigation({Key? key}) : super(key: key);

  @override
  State<ShelterNavigation> createState() => _ShelterNavigationState();
}

class _ShelterNavigationState extends State<ShelterNavigation> {
  //get current home shelter details
  HomeShelter? homeShelter;

  @override
  void initState() {
    super.initState();
    //get current user email
    final String? email = supabase.auth.currentUser!.email;
    print(email);

    //get current home shelter details
    Authentication.getCurrentShelterDetails(email).then((value) => setState(() {
          homeShelter = value;
          print(homeShelter?.toMap());
        }));
  }

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ShelterHomePage(
        id: homeShelter?.id ?? 0,
        title: homeShelter?.name ?? '',
        category: homeShelter?.category ?? '',
        phone: homeShelter?.phone ?? 123456789,
        email: homeShelter?.email ?? '',
        description: homeShelter?.description ?? '',
        banner: homeShelter?.banner ?? '',
        street: homeShelter?.street ?? '',
        city: homeShelter?.city ?? '',
        state: homeShelter?.state ?? '',
      ),
      HistoryPage(
        id: homeShelter?.id ?? 0,
      ),
    ];

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
