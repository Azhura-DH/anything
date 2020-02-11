import 'street.dart';

class Location {
  final Street street;
  final String city, state;

  Location(this.street, this.city, this.state);

  Location.fromJson(Map<String, dynamic> json)
      : street = Street.fromJson(json['street']),
        city = json['city'],
        state = json['state'];
}
