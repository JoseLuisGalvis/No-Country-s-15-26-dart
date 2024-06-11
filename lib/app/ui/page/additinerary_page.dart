import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:turistear_aplication_v1/app/api_connection/dio_instance.dart';
import 'package:turistear_aplication_v1/app/data/model/itenerary.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:turistear_aplication_v1/app/ui/components/form_nombre.dart';

import '../../provider/navigation_provider.dart';


class AddItineraryPage extends StatefulWidget {
  @override
  _AddItineraryPageState createState() => _AddItineraryPageState();
}

class _AddItineraryPageState extends State<AddItineraryPage> {
  final List<String> _names = [];
  int _userId = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _addNameField(String name) {
    setState(() {
      _names.add(name);
    });
  }

  void _removeNameField(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar nombre'),
          content: Text('¿Estás seguro de que quieres eliminar este nombre?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sí'),
              onPressed: () {
                setState(() {
                  _names.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveItinerary() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Registro'),
          content: Text('¿Estás seguro de que quieres registrar este itinerario?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sí'),
              onPressed: () async {
                // Enviar la lista de nombres al servidor para registrar el itinerario
                final response = await DioInstance.post(
                  'http://localhost:2100/itineraries',
                  data: json.encode({'names': _names, 'user_id': _userId}), // Use _userId instead of userId
                );

                if (response.statusCode == 200) {
                  // Itinerario guardado correctamente
                  String successMessage = "Itinerario guardado correctamente.";
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(successMessage),
                      duration: Duration(seconds: 6),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  // Error al guardar el itinerario
                  String errorMessage = "Hubo un problema al guardar el itinerario.";

                  if (response.statusCode == 400) {
                    errorMessage += "\nError 400: Solicitud incorrecta.";
                  } else if (response.statusCode == 401) {
                    errorMessage += "\nError 401: No autorizado.";
                  } else if (response.statusCode == 403) {
                    errorMessage += "\nError 403: Acceso denegado.";
                  } else if (response.statusCode == 404) {
                    errorMessage += "\nError 404: Recurso no encontrado.";
                  } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
                    errorMessage += "\nError 5xx: Problema del servidor.";
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      duration: Duration(seconds: 6),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //...
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.of(context).size.width,
                child: FormNombre(
                  onAddName: _addNameField,
                ),
              ),
              const SizedBox(height: 16),
              // Itinerario
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ExpansionTile(
                  title: Text("Sitios Agregados"),
                  children: <Widget>[
                  // Definir una altura máxima para el contenedor desplazable
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _names.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_names[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeNameField(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveItinerary,
                child: Text('Guardar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0.5, 0.5),
                        blurRadius: 1.0,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ],
                  ),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                  side: MaterialStateProperty.all(BorderSide(color: Colors.transparent)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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