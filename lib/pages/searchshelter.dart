// import 'package:flutter/material.dart';

// class SearchHomeShelter extends StatelessWidget {
//   const SearchHomeShelter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       //appbar
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         automaticallyImplyLeading: false,
//         title: const Padding(
//           padding: EdgeInsets.only(left: 10.0),
//           child: SizedBox(
//               width: 100,
//               child: Image(
//                 image: AssetImage('assets/images/helpus.png'),
//                 fit: BoxFit.cover,
//               )),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: IconButton(
//               iconSize: 30,
//               onPressed: () async {
//                 await Authentication.signOut(context);
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SplashScreen(),
//                     ),
//                         (route) => false);
//               },
//               icon: const Icon(Icons.logout_rounded, color: Colors.black),
//             ),
//           )
//         ],
//       ),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [

//           ],
//         ),
//       ),
//     );
//   }
// }
