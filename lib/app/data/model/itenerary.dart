import 'package:turistear_aplication_v1/app/data/model/favorites_sites.dart';

class Itinerary {
  int? id;
  String nameItinerary;
  String descItinerary;


  Itinerary(this.nameItinerary, this.descItinerary);

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    json["name_itinerary"],
    json["desc_itinerary"]

  );

  Map<String, dynamic> toJson() => {
    'id': id?.toString(),
    'name_itinerary': nameItinerary,
    'desc_itinerary': descItinerary,

  };

  // Getters
  String get name => nameItinerary;
  String get description => descItinerary;
}


