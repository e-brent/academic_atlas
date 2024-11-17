
// id, name, hours, address, picture, coordinates, study spaces

class Location {
  final int id;
  final String name;
  final String hours;
  final String address;
  final String image;
  final double coordNS;
  final double coordEW;

  Location({required this.id, required this.name, required this.hours, required this.address, required this.image, required this.coordNS, required this.coordEW});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      name: json["name"],
      hours: json["hours"],
      address: json["address"],
      image: json["image"],
      coordNS: json["coordNS"],
      coordEW: json["coordEW"]
    );
  }
}