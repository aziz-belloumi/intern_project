import 'dart:io';

import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';

import '../entities/property.dart';
import '../repositories/property_repository.dart';

class AddPropertyUseCase {
  final PropertyRepository repository;

  AddPropertyUseCase({required this.repository});

  Future<PropertyModel> call(
      PropertyModel property, List<File> listImages, File pdfFile) async {
    return repository.addProperty(property, listImages, pdfFile);
  }
}
