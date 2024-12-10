// id, name, location, crowd level, current amenities, general amenities

class Amenities {
  final String amenity;
  bool isSelected;

  Amenities({required this.amenity, this.isSelected=false});

  factory Amenities.fromJson(Map<String, dynamic> json){
    return Amenities(
      amenity: json["amenity"]
    );
  }

  Map<String, String> toJson() =>
      {
        "amenity": amenity,
      };
}

class StudySpace {
  final int id;
  final String name;
  final int location;
  double crowdLevel;
  final List<Amenities> currentAmenities;
  final List<Amenities> generalAmenities;

  StudySpace({required this.id, required this.name, required this.location, required this.crowdLevel, required this.currentAmenities, required this.generalAmenities});

  factory StudySpace.fromJson(Map<String, dynamic> json ){
    final currAmenitiesData = json['currentAmenities'] as List<dynamic>?;
    final genAmenitiesData = json['generalAmenities'] as List<dynamic>?;

    return StudySpace(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      crowdLevel: json["crowdLevel"],
      currentAmenities: currAmenitiesData != null ? currAmenitiesData.map((amenity) => Amenities.fromJson(amenity as Map<String, String>)).toList(): <Amenities>[],
      generalAmenities: genAmenitiesData != null ? genAmenitiesData.map((amenity) => Amenities.fromJson(amenity as Map<String, String>)).toList(): <Amenities>[]
    );
  }
}