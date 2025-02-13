
// username, password, favorites, email, location

class User {
  final String email;
  final String username;
  final String password;
  final List<String> favorites;
  final List<double> location;

  User({required this.email, required this.username, required this.password, required this.favorites, required this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      username: json["username"],
      password: json["password"],
      favorites: json["favorites"],
      location: json["location"]
    );
  }
}