import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/profile_page.dart';

import '../../provider/navigation_provider.dart';
import '../components/custom_app_bar.dart';
import 'home_page.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ConfigurationPage extends StatefulWidget {
  ConfigurationPage({Key? key}) : super(key: key);

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "inactive_icon": Icons.home,
      "label": "",
    },
    {
      "active_icon": Icons.add_card,
      "inactive_icon": Icons.add_card,
      "label": "",
    },
    {
      "active_icon": Icons.person_2,
      "inactive_icon": Icons.person_2,
      "label": "",
    },
  ];

  Uint8List? _selectedImageBytes;
  final ImagePicker _picker = ImagePicker();

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
            SizedBox(height: 10),
            // Foto
            Center(
              child: Column(
                children: [
                  if (_selectedImageBytes!= null)
                    Container(
                      width: 300,
                      height: 250,
                      decoration: BoxDecoration(

                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 10,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ],
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.memory(_selectedImageBytes!, fit: BoxFit.cover),
                    ),
                  SizedBox(height: 18),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () async {
                      try {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile!= null) {
                          _selectedImageBytes = await pickedFile.readAsBytes();
                          setState(() {});
                        } else {
                          print('No se seleccionó ninguna imagen.');
                        }
                      } catch (e) {
                        print('Error: $e');
                      }

                      if (_selectedImageBytes!= null) {
                        await saveImageToFolder(context, _selectedImageBytes!);
                      }
                    },
                    icon: Icon(Icons.image, color: Colors.white),
                    label: Text(
                      'Seleccionar Imagen',
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
                  ),
                ],
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
          opacity: 1,
          child: Container(
            height: 75,

            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 164, 244, 231),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: navigationProvider.currentIndex,
                onTap: (value) {
                  navigationProvider.setIndex(value);
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: List.generate(3, (index) {
                  var navBtnProperty = _navigationButtonProperties[index];
                  return BottomNavigationBarItem(
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: navigationProvider.currentIndex == index
                          ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      )
                          : null,
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
                    label: navBtnProperty["label"],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> saveImageToFolder(BuildContext context, Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final String newPath = '${directory.path}/my_folder/image.jpg';

    final file = File(newPath);
    await file.writeAsBytes(imageBytes);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Imagen guardada en $newPath')));
  }

}

