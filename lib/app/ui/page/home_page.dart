import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:turistear_aplication_v1/app/ui/components/categories_slider.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_category_card.dart';
import 'package:turistear_aplication_v1/app/ui/components/recommendations_slider.dart';

import '../../data/model/detail_item.dart';
import 'detail_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<_MyHomePageState> homePageKey = GlobalKey<_MyHomePageState>();

  final List<String> imageUrls = [
    'assets/home/img1.jpeg',
    'assets/home/img2.jpeg',
    'assets/home/img3.jpeg',
    'assets/home/img4.jpeg',
    'assets/home/img5.jpeg',
  ];

  final List<String> titles = [
    'Barrio La Boca',
    'Mendoza',
    'Talampaya e Ischigualasto',
    'Circuito Salta – Cachi – Cafayate',
    'Ushuaia',
  ];

  // Lista de elementos detallados
  final List<DetailItem> detailItems = [
    DetailItem(
      title: 'Barrio La Boca',
      imageUrl: 'assets/home/img1.jpeg',
      description: 'conocido por su vibrante historia y cultura. Ubicado en la '
          'desembocadura del Riachuelo en el Río de la Plata, La Boca fue un '
          'importante centro portuario que atrajo a inmigrantes de diversas partes'
          ' del mundo, especialmente genoveses, quienes contribuyeron significativamente'
          ' a su característica arquitectura única. Sus casas, construidas con madera '
          'y chapas pintadas con colores brillantes, son famosas por su apariencia'
          ' distintiva y encantadora. ',
    ),
    DetailItem(
      title: 'Mendoza',
      imageUrl: 'assets/home/img2.jpeg',
      description: 'Conocida por su amor a la vid y el vino, Mendoza '
          'ofrece una variedad de bodegas para visitar, especialmente '
          'en las provincias de Tierra Malbec, Luján de Cuyo, Valle de'
          ' Uco y Maipú. Además, se puede disfrutar de la vista desde '
          'el Cerro de la Gloria y explorar la plaza Pedro del Castillo,'
          ' la más antigua de la ciudad',
    ),
    DetailItem(
      title: 'Talampaya e Ischigualasto',
      imageUrl: 'assets/home/img3.jpeg',
      description: 'Ubicados en las provincias de La Rioja y San Juan, '
          'estos parques naturales son conocidos por sus formaciones '
          'geológicas únicas y paisajes desérticos. Popularmente conocido'
          'como "El valle de la luna", Ischigualasto es uno de los sitios'
          'declarados Patrimonio de la Humanidad',
    ),
    DetailItem(
      title: 'Circuito Salta – Cachi – Cafayate',
      imageUrl: 'assets/home/img4.jpeg',
      description: 'Este recorrido por el noroeste argentino ofrece espectaculares'
          ' paisajes y es una alternativa menos conocida pero fascinante para'
          ' quienes buscan escapar de las rutas más transitadas',
    ),
    DetailItem(
      title: 'Ushuaia',
      imageUrl: 'assets/home/img5.jpeg',
      description: 'Conocida como "la ciudad al fin del mundo", Ushuaia es un'
          ' destino mágico para los viajeros. Ofrece actividades como la '
          'navegación por el Canal Beagle y la caminata a la Laguna Esmeralda,'
          ' además de ser el punto de inicio o fin de la Ruta Panamericana',
    ),
  ];

  List<Function(BuildContext, int)> onPressedCallbacks = [];

  void _handleOnPress(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(detailItem: detailItems[index])),
    );
    print('${titles[index]} presionado');
  }

  @override
  void initState() {
    super.initState();
    initCallbacks();
  }

  void initCallbacks() {
    onPressedCallbacks = List.generate(imageUrls.length, (index) {
      return (BuildContext context, int index) {
        _handleOnPress(context, index);
      };
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristApp'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CategoriesSlider(),
              const SizedBox(height: 16),
              RecommendationsSlider(
                imageUrls: imageUrls,
                titles: titles,
                onPressedCallbacks: onPressedCallbacks,
              ),
              const SizedBox(height: 16),
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: const [
                  // Recuadro Mapa
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: CustomCategoryCard(
                      title: 'Mapa',
                      icon: Icons.map,
                      backgroundColor: Color.fromRGBO(26, 188, 156, 1),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ),
                  ),
                  // Recuadro Sitios Turisticos
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: CustomCategoryCard(
                      title: 'Sitios Turisticos',
                      icon: Icons.mode_of_travel,
                      backgroundColor: Color.fromRGBO(255, 212, 38, 1),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ),
                  ),
                  // Recuadro Mis Sitios
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: CustomCategoryCard(
                      title: 'Mis Sitios',
                      icon: Icons.bookmark,
                      backgroundColor: Color.fromRGBO(164, 244, 231, 1),
                      textColor: Colors.black,
                      iconColor: Colors.black,
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
