import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/profile_page.dart';

import '../../provider/navigation_provider.dart';
import '../components/custom_app_bar.dart';
import 'home_page.dart';

class ConfigurationPage extends StatelessWidget {
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
    final Brightness brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: CustomAppBar(title: 'TuristAPP'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 36),
            // Titulo
            Text('Configuración',
              style: TextStyle(
                  color: brightness == Brightness.dark? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            // Foto
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: Text(
                    'Sube tu Foto',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            // Nombre del usuario
            Text(
              'Nombre del Usuario',
              style: TextStyle(fontSize: 16),
            ),
            // Subtítulo Editar Perfil
            Center(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Editar Perfil'),
                  IconButton(
                    icon: Icon(Icons.create),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            // Card Agradecimiento
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Text(
                    'Gracias por tu Visita',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0.7, 0.9),
                          blurRadius: 2.0,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double cardWidth = constraints.maxWidth;
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      // Botón para cerrar sesión
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                                (route) => false,
                          );
                        },
                        child: Text('Cerrar Sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 1.0,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.transparent)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          fixedSize: MaterialStateProperty.all(Size(cardWidth, 35)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
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

