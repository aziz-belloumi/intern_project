import 'dart:io';

import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';

abstract class PropertyRepository {
  Future<PropertyModel> addProperty(
      PropertyModel property, List<File> listImages,File pdfFile);

  Future<List<PropertyModel>> fetchAllProperty();
}
