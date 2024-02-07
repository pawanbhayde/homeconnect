import 'package:flutter/material.dart';

class CustomHistoryCard extends StatelessWidget {
  final String name;
  final String email;
  final String date;
  final String time;

  const CustomHistoryCard({
    super.key,
    required this.name,
    required this.email,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    //convert date to a more readable format
    //dont show time as it is not needed
    final convertdate = DateTime.parse(date).toLocal().toString().split(' ')[0];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Email: $email",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Text(
                "Date: $convertdate",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
