import 'package:flutter/material.dart';

import '../../data/model/my_location.dart';

class MuseosPage extends StatefulWidget {
  const MuseosPage({Key? key}) : super(key: key);

  @override
  State<MuseosPage> createState() => _MuseosPageState();
}

class _MuseosPageState extends State<MuseosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Museos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Museos',
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
    itemCount: MyLocations.museosList.length,
    itemBuilder: (context, index) {
      final location = MyLocations.museosList[index];
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
