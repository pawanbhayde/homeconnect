import 'package:flutter/material.dart';
import 'package:helpus/Widgets/custom_shalter_card.dart';
import 'package:helpus/main.dart';
import 'package:helpus/pages/addhome.dart';
import 'package:helpus/pages/splash_screen.dart';
import 'package:helpus/widgets/custom_category_card.dart';
import 'package:helpus/widgets/custom_image_carousel.dart';
import 'package:helpus/widgets/custom_near_shelter_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: SizedBox(
              width: 100,
              child: Image(
                image: AssetImage('assets/images/helpus.png'),
                fit: BoxFit.cover,
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () async {
                await supabase.auth.signOut();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.notifications, color: Colors.black),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            CarouselWithDotsPage(imgList: const [
              'assets/images/1.jpg',
              'assets/images/2.jpg',
              'assets/images/3.jpg',
            ]),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeCategory(title: 'Food', image: 'assets/images/cat-1.png'),
                HomeCategory(title: 'Cloths', image: 'assets/images/cat-2.png'),
                HomeCategory(
                    title: 'Charity', image: 'assets/images/cat-3.png'),
                HomeCategory(
                    title: 'Education', image: 'assets/images/cat-4.png'),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nearest Shelter Homes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 180,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  const NeedFirstBox(
                    title: 'Shakti NGO Shelter Home',
                    image: 'assets/images/ngo-banner-1.png',
                  ),
                  const NeedFirstBox(
                    title: 'Homies NGO Shelter Home',
                    image: 'assets/images/ngo-banner-2.png',
                  ),
                  const NeedFirstBox(
                    title: 'UNEX NGO Shelter Home',
                    image: 'assets/images/ngo-banner-3.png',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Latest Shelter Homes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const LatestShalter(
              title: 'Shakti NGO Shelter Home',
              image: 'assets/images/ngo-banner-1.png',
              distance: '2.5 km',
            ),
            const LatestShalter(
              title: 'Homies NGO Shelter Home',
              image: 'assets/images/ngo-banner-2.png',
              distance: '3.5 km',
            ),
            const LatestShalter(
              title: 'UNEX NGO Shelter Home',
              image: 'assets/images/ngo-banner-3.png',
              distance: '4.5 km',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFEB61D),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddHomeShelter();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
