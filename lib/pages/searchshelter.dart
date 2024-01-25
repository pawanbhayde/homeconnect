import 'package:flutter/material.dart';
import 'package:helpus/widgets/custom_shalter_card.dart';

class SearchHomeShelter extends StatelessWidget {
  const SearchHomeShelter({super.key});

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

      body: SingleChildScrollView(
        child: Column(
          children: [
            // textfield
            Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              color: const Color(0xffF3F2F5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Latest Shelter Homes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            LatestShalter(
              title: 'Shakti NGO Shelter Home',
              image: 'assets/images/ngo-banner-1.png',
              distance: '2.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'Homies NGO Shelter Home',
              image: 'assets/images/ngo-banner-2.png',
              distance: '3.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'UNEX NGO Shelter Home',
              image: 'assets/images/ngo-banner-3.png',
              distance: '4.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'Shakti NGO Shelter Home',
              image: 'assets/images/ngo-banner-1.png',
              distance: '2.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'Homies NGO Shelter Home',
              image: 'assets/images/ngo-banner-2.png',
              distance: '3.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'UNEX NGO Shelter Home',
              image: 'assets/images/ngo-banner-3.png',
              distance: '4.5 km',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
