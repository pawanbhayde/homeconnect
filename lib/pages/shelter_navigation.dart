import 'package:flutter/material.dart';
import 'package:helpus/pages/historypage.dart';
import 'package:helpus/pages/profile_page.dart';
import 'package:helpus/pages/shelter_homepage.dart';
import 'package:iconsax/iconsax.dart';

// class ShelterNavigation extends StatefulWidget {
//   const ShelterNavigation({Key? key}) : super(key: key);
//
//   @override
//   State<ShelterNavigation> createState() => _ShelterNavigationState();
// }
//
// class _ShelterNavigationState extends State<ShelterNavigation> {
//   //get current home shelter details
//   HomeShelter? homeShelter;
//
//   @override
//   void initState() {
//     super.initState();
//     //get current user email
//     final String? email = supabase.auth.currentUser!.email;
//     print(email);
//
//     // Get user profile
//     Authentication.getCurrentShelterDetails(email).then((value) => setState(() {
//           homeShelter = value;
//           print(homeShelter?.toMap());
//         }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int selectedPage = 0;
//
//     final List<Widget> pages = [
//       // Shelter Detail Page
//       // HomeShelterDetails(
//       //   title: homeShelter!.name,
//       //   phone: homeShelter!.phone,
//       //   category: homeShelter!.category,
//       //   id: homeShelter!.id,
//       // ),
//       ShelterHomePage(),
//       // History Page
//       const HistoryPage(),
//       const ProfileScreen(),
//     ];
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[selectedPage],
//       bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: selectedPage,
//           fixedColor: const Color(0xff395EE7),
//           unselectedItemColor: const Color(0xFF757575),
//           onTap: (position) {
//             setState(() {
//               selectedPage = position;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
//             BottomNavigationBarItem(
//                 icon: Icon(Iconsax.search_normal), label: "Search"),
//             BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Account")
//           ]),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:helpus/pages/home_page.dart';
// import 'package:helpus/pages/profile_page.dart';
// import 'package:helpus/pages/searchshelter.dart';
// import 'package:iconsax/iconsax.dart';

class ShelterNavigation extends StatefulWidget {
  const ShelterNavigation({Key? key}) : super(key: key);

  @override
  State<ShelterNavigation> createState() => _ShelterNavigationState();
}

class _ShelterNavigationState extends State<ShelterNavigation> {
  int selectedPage = 0;
  final List<Widget> pages = [
    const ShelterHomePage(),
    const HistoryPage(),
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
