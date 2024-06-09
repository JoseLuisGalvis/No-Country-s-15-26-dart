import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/api_connection/dio_instance.dart';
import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:turistear_aplication_v1/app/ui/components/form_nombre.dart';

import '../../provider/navigation_provider.dart';

class AddItineraryPage extends StatelessWidget {
  AddItineraryPage({super.key});

  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "inactive_icon": Icons.home,
      "label": "", // Etiqueta vacía
    },
    {
      "active_icon": Icons.add_card,
      "inactive_icon": Icons.add_card,
      "label": "", // Etiqueta vacía
    },
    {
      "active_icon": Icons.person_2,
      "inactive_icon": Icons.person_2,
      "label": "", // Etiqueta vacía
    },
  ];

  Future<void> saveItinerary(String name, String description) async {
    // Asume que quieres iniciar sin sitios favoritos
    final Itinerary itinerary = Itinerary(name, description);

    final response = await DioInstance.post(
      'http://localhost:2100/itineraries',
      data: json.encode(itinerary.toJson()),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Itinerario guardado correctamente');
      }
    } else {
      if (kDebugMode) {
        print('Error al guardar el itinerario: ${response.data}');
      }
    }
  }



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
                alignment: Alignment
                    .center, // Asegura que el texto esté alineado a la izquierda
                child: Text(
                  'Crea Nuevo Itinerario',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize:
                    16.sp, // Usa ScreenUtil para el tamaño del texto
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Bloque ItineraryList()
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: const ExpansionTile(
                  title: Text("Sitios Agregados"),
                  children: <Widget>[
                    // Definir una altura máxima para el contenedor desplazable
                    SizedBox(
                      height: 200, // Ajusta la altura según sea necesario
                      child: SingleChildScrollView(
                        child: ItineraryList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Bloque FormNombre
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width,
                child: FormNombre(
                  onSave: (name, description) {
                    saveItinerary(name, description); // Ahora pasa ambos, nombre y descripción
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Opacity(
          opacity: 1, // Ajusta la opacidad aquí
          child: Container(
            height: 75, // Ajusta la altura aquí

            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 164, 244, 231),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent, // Hacer el fondo transparente para mostrar el color del contenedor
                currentIndex: navigationProvider.currentIndex,
                onTap: (value) {
                  navigationProvider.setIndex(value);
                },
                showSelectedLabels: false, // Ocultar etiquetas seleccionadas
                showUnselectedLabels: false, // Ocultar etiquetas no seleccionadas
                items: List.generate(3, (index) {
                  var navBtnProperty = _navigationButtonProperties[index];
                  return BottomNavigationBarItem(
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: navigationProvider.currentIndex == index
                          ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal, // Color de fondo del círculo activo
                        border: Border.all(
                          color: Colors.white, // Color del borde blanco
                          width: 2.0, // Ancho del borde
                        ),
                      )
                          : null, // Sin decoración para el ícono inactivo
                      child: Icon(
                        navigationProvider.currentIndex == index
                            ? navBtnProperty["active_icon"]
                            : navBtnProperty["inactive_icon"],
                        size: 25,
                        color: navigationProvider.currentIndex == index
                            ? Colors.black
                            : Colors.black,
                      ),
                    ),
                    label: navBtnProperty["label"], // Etiqueta vacía
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}


class ItineraryList extends StatefulWidget {
  const ItineraryList({super.key});

  @override
  State<ItineraryList> createState() => _ItineraryListState();
}

class _ItineraryListState extends State<ItineraryList> {
  Future<List<Itinerary>>? _futureItineraries;

  @override
  void initState() {
    super.initState();
    _futureItineraries = DioInstance.get('http://localhost:2100/getitineraries').then((response) {
      return (response.data as List).map((itinerary) => Itinerary.fromJson(itinerary)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureItineraries,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Itinerary> itineraries = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: itineraries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(itineraries[index].nameItinerary),
                subtitle: Text(itineraries[index].descItinerary),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}