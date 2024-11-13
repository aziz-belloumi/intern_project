import 'dart:io';

import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/property.dart';

// Base Property Event
abstract class PropertyEvent {}

// Event to add a new property
class AddProperty extends PropertyEvent {
  final PropertyModel property;

  AddProperty(this.property);
}

// class FetchAllProperty extends PropertyEvent {
//   final List<PropertyModel> properties;
//
//   FetchAllProperty(this.properties);
// }

class FetchAllProperty extends PropertyEvent {
  // No need to pass properties here
  FetchAllProperty();
}


// Event to select a property type by index
class SelectPropertyType extends PropertyEvent {
  final int index;

  SelectPropertyType(this.index);
}

// Event to select a location
class SelectLocation extends PropertyEvent {
  final Location selectedLocation;

  SelectLocation(this.selectedLocation);
}

// Event for selecting amenities
class SelectAmenity extends PropertyEvent {
  final String amenityName;
  final bool isSelected;

  SelectAmenity({required this.amenityName, required this.isSelected});
}

// Events for uploading a photo
class UploadPhoto extends PropertyEvent {
  final int index;
  final String filePath;
  final File imageFile;

  UploadPhoto({
    required this.index,
    required this.filePath,
    required this.imageFile,
  });
}

// Event for uploading a PDF file
class UploadPdfFile extends PropertyEvent {
  final File pdfFile;

  UploadPdfFile({
    required this.pdfFile,
  });

  String get filePath => pdfFile.path;
}


// Event for selecting the title of the property
class SelectTitle extends PropertyEvent {
  final String title;

  SelectTitle(this.title);
}

// Event for selecting the description of the property
class SelectDescription extends PropertyEvent {
  final String description;

  SelectDescription(this.description);
}

// Event for selecting the price of the property
class SelectPrice extends PropertyEvent {
  final String price;

  SelectPrice(this.price);
}

// Event for selecting the type (e.g., rent, sale)
class TypePrice extends PropertyEvent {
  final String type;

  TypePrice(this.type);
}

// Event for selecting the duration (e.g., monthly, yearly)
class SelectDuration extends PropertyEvent {
  final String duration;

  SelectDuration(this.duration);
}

// Event for updating an existing property
class UpdateProperty extends PropertyEvent {
  final Property updatedProperty;

  UpdateProperty(this.updatedProperty);
}

// Event for incrementing bedrooms counter
class IncrementBedrooms extends PropertyEvent {}

// Event for decrementing bedrooms counter
class DecrementBedrooms extends PropertyEvent {}

// Event for incrementing beds counter
class IncrementBeds extends PropertyEvent {}

// Event for decrementing beds counter
class DecrementBeds extends PropertyEvent {}

// Event for incrementing bathrooms counter
class IncrementBathroomsCounter extends PropertyEvent {}

// Event for decrementing bathrooms counter
class DecrementBathroomsCounter extends PropertyEvent {}
