import 'dart:io';

import 'package:convergeimmob/features/immobilier/data/datasources/property_remote_data_source.dart';
import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';

import '../../domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;

  PropertyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PropertyModel> addProperty(PropertyModel property, List<File> listImages,File pdfFile) async {
    return await remoteDataSource.addProperty(property, listImages,pdfFile);
  }

  @override
  Future<List<PropertyModel>> fetchAllProperty() async {
    return await remoteDataSource.fetchAllProperty();
  }

}

