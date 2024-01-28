import 'package:flutter/material.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/pages/home_shelter_detail.dart';
import 'package:helpus/widgets/custom_shalter_card.dart';

class DonationCategoryPage extends StatelessWidget {
  const DonationCategoryPage({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    // select chip of received category
    bool food = false;

    bool clothes = false;

    bool charity = false;

    bool education = false;

    if (category == 'food') {
      food = true;
    } else if (category == 'clothes') {
      clothes = true;
    } else if (category == 'charity') {
      charity = true;
    } else if (category == 'education') {
      education = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Category'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // category chips for food, clothes, etc
            // Listview Horizontal
            SizedBox(
              height: 50,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Food'),
                    selected: food,
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Cloths'),
                    selected: clothes,
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Charity'),
                    selected: charity,
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Education'),
                    selected: education,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Home Shelters That Need ${category}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // list of shelters that need food
            StreamBuilder(
              stream: DatabaseService.getShelterStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('An error occurred'),
                  );
                } else if (snapshot.hasData) {
                  //final shelters = snapshot.data as List<HomeShelter>;
                  final filteredData = (snapshot.data as List).where((shelter) {
                    return (shelter['category'] as String)
                        .toLowerCase()
                        .contains(category.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return LatestShelter(
                        title: filteredData[index]['name'],
                        category: filteredData[index]['category'],
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
                } else {
                  return Center(
                    child: Text('Unknown state'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
