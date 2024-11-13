import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({double? latitude, double? longitude, String? address})
      : super(latitude: latitude, longitude: longitude, address: address);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}
