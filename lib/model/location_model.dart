
// id, name, hours, address, picture, coordinates, study spaces

class Location {
  final int id;
  final String name;
  //final Map<String, List<double>> hours;
  final String address;
  final String image;
  //final List<double> coordinates;
  //final List<int> studySpaces;

  Location({required this.id, required this.name, required this.address, required this.image});
  //required this.hours,
  //, required this.coordinates, required this.studySpaces

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      name: json["name"],
      //hours: json["hours"],
      address: json["address"],
      image: json["image"],
      //coordinates: json["coordinates"],
      //studySpaces: json["studySpaces"],
    );
  }
}