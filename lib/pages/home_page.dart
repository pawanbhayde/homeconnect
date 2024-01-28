import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/pages/addhome.dart';
import 'package:helpus/pages/home_shelter_detail.dart';
import 'package:helpus/widgets/custom_category_card.dart';
import 'package:helpus/widgets/custom_image_carousel.dart';
import 'package:helpus/widgets/custom_near_shelter_card.dart';
import 'package:helpus/widgets/custom_shalter_card.dart';

import 'donation_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get current user
  UserProfile? user;
  @override
  void initState() {
    super.initState();

    // Get user profile
    Authentication.getCurrentUser().then((value) => setState(() {
          user = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //appbar
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const SizedBox(
          width: 150,
          child: Image(
            image: AssetImage('assets/images/helpus.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),

      //body
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),

            //image carousel
            CarouselWithDotsPage(imgList: const [
              'assets/images/food.png',
              'assets/images/cloths.png',
              'assets/images/education.png',
              'assets/images/charity.png',
            ]),
            SizedBox(
              height: size.height * 0.03,
            ),

            //Donation Categories
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Donation Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeCategory(
                  title: 'Food',
                  image: 'assets/images/cat-1.png',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DonationCategoryPage(
                            category: 'food',
                          );
                        },
                      ),
                    );
                  },
                ),
                HomeCategory(
                  title: 'Cloths',
                  image: 'assets/images/cat-2.png',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DonationCategoryPage(
                            category: 'clothes',
                          );
                        },
                      ),
                    );
                  },
                ),
                HomeCategory(
                  title: 'Charity',
                  image: 'assets/images/cat-3.png',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DonationCategoryPage(
                            category: 'charity',
                          );
                        },
                      ),
                    );
                  },
                ),
                HomeCategory(
                  title: 'Education',
                  image: 'assets/images/cat-4.png',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DonationCategoryPage(
                            category: 'education',
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),

            //Nearest Shelter Homes
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
            //nearest shelter homes cards
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 180,
                child: StreamBuilder(
                  stream: DatabaseService.getNearShelterStream(user!.city),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('An error occurred: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data?.length == 0) {
                        return Center(
                          child: Text('No data available'),
                        );
                      } else {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return NeedFirstBox(
                              title: snapshot.data?[index]['name'],
                              category: snapshot.data?[index]['category'],
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeShelterDetails(
                                    id: snapshot.data?[index]['id'],
                                    title: snapshot.data?[index]['name'],
                                    category: snapshot.data?[index]['category'],
                                    phone: snapshot.data?[index]['phone'],
                                  );
                                }));
                              },
                            );
                          },
                        );
                      }
                    } else {
                      return Center(
                        child: Text('Unknown state'),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),

            //Latest Shelter Homes
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
            //latest shelter homes cards
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: StreamBuilder(
                  stream: DatabaseService.getShelterStream(),
                  builder: (context, snapshot) {
                    // ignore: avoid_print
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return LatestShelter(
                            title: snapshot.data?[index]['name'],
                            category: snapshot.data?[index]['category'],
                            //navigate to shelter details page with data when pressed
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeShelterDetails(
                                  id: snapshot.data?[index]['id'],
                                  title: snapshot.data?[index]['name'],
                                  category: snapshot.data?[index]['category'],
                                  phone: snapshot.data?[index]['phone'],
                                );
                              }));
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff395EE7),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddHomeShelter();
          }));
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
