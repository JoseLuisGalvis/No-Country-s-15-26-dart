
class Itinerary {
  int? id;
  String nameItinerary;
  final List<String> names;

  Itinerary({required this.nameItinerary, this.names = const []});

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    nameItinerary: json["name_itinerary"],
    names: json["names"].cast<String>(),
  );

  Map<String, dynamic> toJson() => {
    'id': id?.toString(),
    'name_itinerary': nameItinerary,
    'names': names,
  };

  // Getters
  String get name => nameItinerary;
}


