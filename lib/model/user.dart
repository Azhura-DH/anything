import 'name.dart';
import 'picture.dart';
import 'location.dart';

class User {
  final String gender, email;
  final Name name;
  final Picture picture;
  final Location location;

  User(this.gender, this.email, this.name, this.picture, this.location);

  User.fromJson(Map<String, dynamic> json)
      : gender = json['gender'],
        email = json['email'],
        name = Name.fromJson(json['name']),
        picture = Picture.fromJson(json['picture']),
        location = Location.fromJson(json['location']);
}
