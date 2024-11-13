import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';

Future<List<Location?>> getCoordinateFromAddress(String address) async {
  final String accessKey =
      '77995de0f5b84f0fcc2b8683d4bbabc4'; // Your API access key
  final String apiUrl =
      'http://api.positionstack.com/v1/forward?access_key=$accessKey&query=$address';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Check if the data list is available in the response
      if (data['data'] != null && data['data'].isNotEmpty) {
        // Map the results to a list of Location objects
        List<Location?> locations = data['data'].map<Location?>((locationData) {
          if (locationData['latitude'] != null &&
              locationData['longitude'] != null &&
              locationData['label'] != null) {
            return Location(
              latitude: locationData['latitude'],
              longitude: locationData['longitude'],
              address: locationData['label'],
            );
          } else {
            return null;
          }
        }).toList();
        print(locations);
        return locations;
      } else {
        // Handle case where no data is returned
        return [];
      }
    } else {
      // Handle the error response
      print('Failed to load location data');
      return [];
    }
  } catch (e) {
    // Handle the exception
    print('Error: $e');
    return [];
  }
}
