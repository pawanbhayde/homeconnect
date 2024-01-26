import 'package:flutter/material.dart';
import 'package:helpus/utilities/colors.dart';

import '../Widgets/custom_shalter_card.dart';

class DonationCategoryPage extends StatelessWidget {
  const DonationCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                children:  [
                  SizedBox(width: 10),

                  ChoiceChip(
                    label: Text('Food'),
                    selected: true,

                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    label: Text('Cloths'),
                    selected: false,
                  ),
                  SizedBox(width: 10),

                  ChoiceChip(
                    label: Text('Charity'),
                    selected: false,
                  ),
                  SizedBox(width: 10),

                  ChoiceChip(
                    label: Text('Education'),
                    selected: false,
                  ),
                  SizedBox(width: 10),

                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Home Shelters That Need Food', style: TextStyle(fontSize: 18, ),),
            ),
            SizedBox(height: 10),
            // list of shelters that need food
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return LatestShalter(
                  title: 'Homies NGO Shelter Home',
                  image: 'assets/images/ngo-banner-2.png',
                  distance: '3.5 km',
                  onPressed: () {},
                );
              },
            ),
            ],
        ),
                  ),
    );
  }
}
