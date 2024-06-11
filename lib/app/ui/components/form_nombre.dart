import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormNombre extends StatefulWidget {
  final Function(String) onAddName;

  const FormNombre({Key? key, required this.onAddName}) : super(key: key);

  @override
  _FormNombreState createState() => _FormNombreState();
}

class _FormNombreState extends State<FormNombre> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), // Cambia el valor de padding según tus necesidades
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Agrega Un Nombre',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Itinerario',
                labelStyle: TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del itinerario';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onAddName(_nameController.text);
                  _nameController.clear();
                }
              },
              child: Text('Agregar',
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
    );
  }
}

