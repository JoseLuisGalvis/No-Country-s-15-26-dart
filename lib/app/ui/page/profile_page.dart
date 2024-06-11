import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';

import '../../data/model/image_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSelectedCuenta = true;
  bool isSelectedAjustes = false;

  void toggleOption(int index) {
    setState(() {
      if (index == 0) {
        isSelectedCuenta = true;
        isSelectedAjustes = false;
      } else {
        isSelectedCuenta = false;
        isSelectedAjustes = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    var imageModel = Provider.of<ImageModel>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'TuristAPP'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo
            Text('Perfil',
              style: TextStyle(
                  color: brightness == Brightness.dark? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20),
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
                  child: imageModel.imageBytes!= null // Verifica si hay una imagen cargada
                      ? Image.memory(imageModel.imageBytes!, fit: BoxFit.cover) // Muestra la imagen
                      : Text(
                    'Sube tu Foto',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Boton Selector
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  isSelected: [isSelectedCuenta, isSelectedAjustes],
                  onPressed: toggleOption,
                  selectedColor: Colors.white,
                  selectedBorderColor: Colors.amber,
                  fillColor: Colors.amber,
                  splashColor: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Cuenta'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Ajustes'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            // Formulario
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSelectedCuenta? 'Cuenta' : 'Ajustes',
                    style: TextStyle(
                      color: brightness == Brightness.dark? Colors.white : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    isSelectedCuenta? 'Realice los cambios en su cuenta aquí. Haga clic en guardar cuando haya terminado.' :
                    'Realice los cambios en su cuenta aquí. Haga clic en guardar cuando haya terminado.',
                  ),
                  SizedBox(height: 20),
                  TextField(
                      decoration: InputDecoration(
                        labelText: isSelectedCuenta? 'Nombre' : 'Correo Electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 10),
                  TextField(
                      decoration: InputDecoration(
                        labelText: isSelectedCuenta? 'Usuario' : 'Celular',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Guardar',
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
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                      side: MaterialStateProperty.all(BorderSide(color: Colors.transparent)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

