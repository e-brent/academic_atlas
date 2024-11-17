import 'package:academic_atlas/model/user_model.dart';

class UserViewModel{
  final User user;

  UserViewModel({required this.user});

  String get email {
    return user.email;
  }

  String get username{
    return user.username;
  }

  String get password{
    return user.password;
  }

  List<String> get favorites{
    return user.favorites;
  }

  List<double> get location{
    return user.location;
  }

}