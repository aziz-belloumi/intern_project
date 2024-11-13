

import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/features/immobilier/domain/repositories/property_repository.dart';

class FetchAllPropertiesUseCase {
  final PropertyRepository repository;

  FetchAllPropertiesUseCase({required this.repository});

  Future<List<PropertyModel>> call() async {
    return repository.fetchAllProperty();
  }
}

