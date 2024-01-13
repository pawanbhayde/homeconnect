import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glass/glass.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SizedBox(
              width: 100,
              child: Image(
                image: AssetImage('assets/images/helpus.png'),
                fit: BoxFit.cover,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Need To Help First',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  NeedFirstBox(),
                  NeedFirstBox(),
                  NeedFirstBox(),
                ],
              ),
            ),
          ],
        ));
  }
}

class NeedFirstBox extends StatelessWidget {
  const NeedFirstBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/2.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        //
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'crop.title',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ).asGlass(
            tintColor: Colors.black.withOpacity(0.2),
            clipBorderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          )
        ],
      ),
    );
  }
}

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class CarouselWithDotsPage extends StatefulWidget {
  List<String> imgList;

  CarouselWithDotsPage({required this.imgList});

  @override
  _CarouselWithDotsPageState createState() => _CarouselWithDotsPageState();
}

class _CarouselWithDotsPageState extends State<CarouselWithDotsPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map(
          (item) => ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            child: Stack(
              children: [
                Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(5),
        ),
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
