import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/ui/components/category_card.dart';
import 'package:turistear_aplication_v1/app/ui/page/parques_page.dart';

import '../page/gastronomia_page.dart';
import '../page/monumentos_page.dart';
import '../page/museos_page.dart';
import '../page/reservas_page.dart';

class CategoriesSlider extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Museos', 'icon': Icons.museum, 'page': MuseosPage()},
    {'title': 'Parques', 'icon': Icons.park, 'page': ParquesPage()},
    {'title': 'Monumentos', 'icon': Icons.account_balance, 'page': MonumentosPage()},
    {'title': 'Reservas', 'icon': Icons.nature, 'page': ReservasPage()},
    {'title': 'Gastronomía', 'icon': Icons.restaurant, 'page': GastronomiaPage()},
  ];

  CategoriesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return CategoryCard(
            title: category['title'],
            icon: category['icon'],
            onTap: category.containsKey('page')
                ? () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => category['page']),
              );
            }
                : null,
          );
        }).toList(),
      ),
    );
  }
}