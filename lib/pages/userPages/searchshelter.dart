import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/pages/userPages/home_shelter_detail.dart';
import 'package:helpus/widgets/custom_shalter_card.dart';

class SearchHomeShelter extends StatefulWidget {
  const SearchHomeShelter({super.key});

  @override
  State<SearchHomeShelter> createState() => _SearchHomeShelterState();
}

class _SearchHomeShelterState extends State<SearchHomeShelter> {
  //get current user
  UserProfile? user;
  String searchTerm = '';

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
    return Scaffold(
      //appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: const SizedBox(
            width: 150,
            child: Image(
              image: AssetImage('assets/images/helpus.png'),
              fit: BoxFit.cover,
            )),
      ),

      body: Column(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            color: const Color(0xffF3F2F5),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Search Shelter',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // text
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Shelter Homes in ${user!.city}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: DatabaseService.getShelterStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                } else if (snapshot.hasData) {
                  //filter data based on search term
                  final filteredData = (snapshot.data as List).where((shelter) {
                    return (shelter['name'] as String)
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase());
                  }).toList();

                  if (filteredData.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return LatestShelter(
                          title: filteredData[index]['name'],
                          category: filteredData[index]['category'],
                          image: filteredData[index]['banner'],
                          //navigate to shelter details page with data when pressed
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeShelterDetails(
                                id: filteredData[index]['id'],
                                title: filteredData[index]['name'],
                                category: filteredData[index]['category'],
                                phone: filteredData[index]['phone'],
                              );
                            }));
                          },
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Unknown state'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
