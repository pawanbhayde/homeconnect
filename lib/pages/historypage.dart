import 'package:flutter/material.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/widgets/custom_history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: DatabaseService.getCallerStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('An error occurred: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              print(snapshot.data as List);
              //filter data based on shelter id
              final filteredData = (snapshot.data as List)
                  .where((element) => element['shelterId'] == widget.id)
                  .toList();

              print('This is filtered Stream:$filteredData');

              if (filteredData.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: filteredData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomHistoryCard(
                        name: filteredData[index]['name'],
                        email: filteredData[index]['email'],
                        date: filteredData[index]['date'],
                        time: filteredData[index]['time'],
                      ),
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
    );
  }
}
