import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const SizedBox(
            width: 150,
            child: Image(
              image: AssetImage('assets/images/helpus.png'),
              fit: BoxFit.cover,
            )),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Help & Support",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "If you have any questions or concerns, please contact us at",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              HelpAndSupport_Custom_Card(
                title: "02227610846",
                subtitle: "Our 24x7 Customer Support",
                icon: Iconsax.call,
              ),
              SizedBox(height: 20),
              HelpAndSupport_Custom_Card(
                title: "homeconnet@support.com",
                subtitle: "Write us at",
                icon: Iconsax.message,
              ),
              SizedBox(height: 20),
              Text("Frequency Asked Questions",
                  style: TextStyle(
                    fontSize: 16,
                  )),
              SizedBox(height: 20),
              ExpansionTile(
                title: Text('How to donate food?'),
                children: [
                  Text(
                      'You can donate food by clicking on the donate food button on the home page and filling the form.'),
                ],
              ),
              ExpansionTile(
                title: Text('How to donate money?'),
                children: [
                  Text(
                      'You can donate money by clicking on the donate money button on the home page and filling the form.'),
                ],
              ),
              ExpansionTile(
                title: Text('How to donate clothes?'),
                children: [
                  Text(
                      'You can donate clothes by clicking on the donate clothes button on the home page and filling the form.'),
                ],
              ),
              ExpansionTile(
                title: Text('How to donate books?'),
                children: [
                  Text(
                      'You can donate books by clicking on the donate books button on the home page and filling the form.'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpAndSupport_Custom_Card extends StatelessWidget {
  const HelpAndSupport_Custom_Card({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xffF3F2F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff185ADB),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Iconsax.arrow_right_3,
            size: 20,
          ),
        ],
      ),
    );
  }
}
