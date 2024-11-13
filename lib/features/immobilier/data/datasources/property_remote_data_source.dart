import 'dart:convert';
import 'dart:io';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/router.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/property_model.dart';

abstract class PropertyRemoteDataSource {
  Future<PropertyModel> addProperty(
      PropertyModel property, List<File> listingPhotoPaths, File pdfFile);

  Future<List<PropertyModel>> fetchAllProperty();
}

class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  final http.Client client;

  PropertyRemoteDataSourceImpl({required this.client});

  @override
  Future<PropertyModel> addProperty(PropertyModel property,
      List<File> listingPhotoPaths, File pdfFile) async {
    print("it is working 1");
    print(pdfFile);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${local}/api/properties/add'),
    );

    // Add fields to the request
    request.fields['creator'] = property.creator ?? '';
    request.fields['category'] = property.category ?? '';
    request.fields['streetAddress'] = property.streetAddress ?? '';
    request.fields['aptSuite'] = property.aptSuite ?? '';
    request.fields['city'] = property.city ?? '';
    request.fields['province'] = property.province ?? '';
    request.fields['country'] = property.country ?? '';
    request.fields['guestCount'] = property.guestCount?.toString() ?? '';
    request.fields['location'] = jsonEncode({
      'latitude': property.location?.latitude,
      'longitude': property.location?.longitude,
      'address': property.location?.address,
    });
    request.fields['bedroomCount'] = property.bedroomCount?.toString() ?? '';
    request.fields['bedCount'] = property.bedCount?.toString() ?? '';
    request.fields['bathroomCount'] = property.bathroomCount?.toString() ?? '';
    request.fields['amenities'] = jsonEncode(property.amenities);
    request.fields['title'] = property.title ?? '';
    request.fields['description'] = property.description ?? '';
    request.fields['highlight'] = property.highlight ?? '';
    request.fields['highlightDesc'] = property.highlightDesc ?? '';
    request.fields['price'] = property.price?.toString() ?? '';
    request.fields['immobStatus'] = property.immobStatus ?? '';
    request.fields['paymentInterval'] = property.paymentInterval ?? '';
    request.fields['VRTour'] = property.VRTour?.toString() ?? '';

    // Add listing photos to the request
    for (var image in listingPhotoPaths) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();

      var multipartFile = http.MultipartFile(
        'otherImg',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }
    print("it is working 2");

    // Add the PDF file to the request
// Add the PDF file to the request
    if (pdfFile != null) {
      try {
        print("Starting to process PDF file");
        print(pdfFile);
        var pdfStream = http.ByteStream(pdfFile.openRead());
        var pdfLength = await pdfFile.length();
        var pdfMultipartFile = http.MultipartFile(
          'pdfFile',
          pdfStream,
          pdfLength,
          filename: pdfFile.path.split('/').last,
        );
        print("PDF file processed, adding to request");
        request.files.add(pdfMultipartFile);
      } catch (e) {
        print("Error processing PDF file: $e");
      }
    }

    print(request);

    // Send the request
    var response = await request.send();

    print(response.statusCode);
    print("it is working 3");

    // Handle the response
    if (response.statusCode == 201) {
      print(response.statusCode);
      var responseBody = await http.Response.fromStream(response);
      Get.offNamedUntil(
          RoutesClass.homeNavigatorScreen, (route) => route.isFirst);
      return PropertyModel.fromJson(jsonDecode(responseBody.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to add property');
    }
  }

  Future<List<PropertyModel>> fetchAllProperty() async {
    try {
      print("Fetching all properties...");

      var request = http.MultipartRequest(
        'GET',
        Uri.parse('$local/api/properties/all'),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print("Request successful with status code: ${response.statusCode}");

        var responseBody = await http.Response.fromStream(response);

        print(responseBody);

        List<dynamic> jsonList = jsonDecode(responseBody.body);

        print(jsonList);

        // Ensure that each item in the list is a Map<String, dynamic> and parse it
        List<PropertyModel> properties = jsonList
            .map((jsonItem) =>
                PropertyModel.fromJson(jsonItem as Map<String, dynamic>))
            .toList();

        return properties;
      } else {
        print("Request failed with status code: ${response.statusCode}");
        throw Exception('Failed to fetch properties');
      }
    } catch (error) {
      print("Error fetching properties: $error");
      throw Exception('Failed to fetch properties');
    }
  }
}
