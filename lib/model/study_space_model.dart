// id, name, location, crowd level, current amenities, general amenities

class Amenities {
  final String amenity;

  Amenities({required this.amenity});

  factory Amenities.fromJson(Map<String, dynamic> json){
    return Amenities(
      amenity: json["amenity"]
    );
  }
}

class StudySpace {
  final int id;
  final String name;
  final int location;
  final double crowdLevel;
  final List<Amenities> currentAmenities;
  final List<Amenities> generalAmenities;

  StudySpace({required this.id, required this.name, required this.location, required this.crowdLevel, required this.currentAmenities, required this.generalAmenities});

  factory StudySpace.fromJson(Map<String, dynamic> json ){
    return StudySpace(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      crowdLevel: json["crowdLevel"],
      currentAmenities: json["currentAmenities"].map((amenity) => Amenities.fromJson(amenity as Map<String, dynamic>)).toList(),
      generalAmenities: json["generalAmenities"].map((amenity) => Amenities.fromJson(amenity as Map<String, dynamic>)).toList()
    );
  }
}