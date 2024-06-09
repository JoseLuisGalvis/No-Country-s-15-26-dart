import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';

import '../components/dashed_border_painter.dart';
import 'additinerary_page.dart';


class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Bloque Encabezado
              Align(
                alignment: Alignment.center, // Asegura que el texto esté alineado a la izquierda
                child: Text(
                  'Crea Nuevo Itinerario',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp, // Usa ScreenUtil para el tamaño del texto
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Iconos de location con línea punteada
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddItineraryPage()),
                          );
                        },
                        child: Icon(Icons.location_on, size: 36.0),
                      ),
                      Text('Agregar'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomPaint(
                      size: Size(150, 1),
                      painter: DashedBorderPainter(),
                    ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.location_on, size: 36.0),
                      Text('Guardar'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 8.0, // Agrega un box shadow con una elevación de 8.0
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.green,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                          crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
                          children: [
                            Icon(Icons.map, color: Colors.black, size: 72.0), // Cambia el color del icono a negro
                            Text('Mapa', style: TextStyle(color: Colors.black)), // Cambia el color del texto a negro
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8.0, // Agrega un box shadow con una elevación de 8.0
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.amber,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                          crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
                          children: [
                            Icon(Icons.luggage_sharp, color: Colors.black, size: 72.0), // Cambia el color del icono a negro
                            Text('Sitios Turísticos', style: TextStyle(color: Colors.black)), // Cambia el color del texto a negro
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

