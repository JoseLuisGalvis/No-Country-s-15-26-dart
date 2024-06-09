import 'package:flutter/material.dart';

import '../../data/model/my_location.dart';

class ParquesPage extends StatefulWidget {
  const ParquesPage({Key? key}) : super(key: key);

  @override
  State<ParquesPage> createState() => _ParquesPageState();
}

class _ParquesPageState extends State<ParquesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parques'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Parques',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildMonumentos()
          ],
        ),
      ),
    );
  }
}

_buildMonumentos() => SizedBox(
  height: 630,
  child: GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (100 / 100),
      crossAxisSpacing: 6,
      mainAxisSpacing: 12,
    ),
    scrollDirection: Axis.vertical,
    itemCount: MyLocations.parquesList.length,
    itemBuilder: (context, index) {
      final location = MyLocations.parquesList[index];
      return Card(
        child: Column(
          children: [
            Container(
              height: 140,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  location.image,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              location.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    },
  ),
);