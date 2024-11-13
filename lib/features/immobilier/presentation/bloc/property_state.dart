import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';

// Base Property State
abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class ListPropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final PropertyModel property;

  PropertyLoaded(this.property);
}

class ListPropertyLoaded extends PropertyState {
  final List<PropertyModel> properties;

  ListPropertyLoaded(this.properties);
}

// State when there is an error in a property-related operation
class PropertyError extends PropertyState {
  final String message;

  PropertyError(this.message);
}

class PropertyEmpty extends PropertyState {
  PropertyEmpty();
}

// State when a specific property type is selected
class PropertyTypeSelected extends PropertyState {
  final int selectedIndex;

  PropertyTypeSelected(this.selectedIndex);
}

// State when a location has been selected for the property
class LocationSelected extends PropertyState {
  final Location selectedLocation;

  LocationSelected(this.selectedLocation);
}

// State when the property is updated with new values (e.g., location, amenities, etc.)
class PropertyUpdatedState extends PropertyState {
  final PropertyModel property;

  PropertyUpdatedState({required this.property});

  @override
  List<Object?> get props => [property];
}

// State for updating the selection of amenities
class AmenitiesSelectionUpdated extends PropertyState {
  final List<String> selectedAmenities;

  AmenitiesSelectionUpdated(this.selectedAmenities);
}

// State for when photos are uploaded
class PhotosUploaded extends PropertyState {
  final Map<int, String> photos;

  PhotosUploaded(this.photos);
}

class PdfFileUploaded extends PropertyState {
  final String pdfFilePath;

  PdfFileUploaded(this.pdfFilePath);

  @override
  List<Object> get props => [pdfFilePath];
}

// State for when the title is selected or updated
class TitleSelected extends PropertyState {
  final String title;

  TitleSelected(this.title);
}

// State for when the description is selected or updated
class DescriptionSelected extends PropertyState {
  final String description;

  DescriptionSelected(this.description);
}

// State for when the price is selected or updated
class PriceSelected extends PropertyState {
  final double price;

  PriceSelected(this.price);
}

// State for when the type (e.g., rent, sale) is selected or updated
class TypeSelected extends PropertyState {
  final String type;

  TypeSelected(this.type);
}

// State for when the duration (e.g., monthly, yearly) is selected or updated
class DurationSelected extends PropertyState {
  final String duration;

  DurationSelected(this.duration);
}

// State for specific amenity selection (e.g., TV, hot tub, etc.)
class SpecificAmenitySelected extends PropertyState {
  final String amenityName;
  final bool isSelected;

  SpecificAmenitySelected(this.amenityName, this.isSelected);
}

// State for when the property is updated with new data (more general)
class PropertyUpdated extends PropertyState {
  final PropertyModel property;

  PropertyUpdated(this.property);
}

// State for handling bathroom counter updates
class CounterBathroomsUpdated extends PropertyState {
  final int counterBathroomsValue;

  CounterBathroomsUpdated(this.counterBathroomsValue);

  @override
  List<Object?> get props => [counterBathroomsValue];
}

class AllProperties extends PropertyState {
  final List<PropertyModel> properties;

  AllProperties(this.properties);
}
