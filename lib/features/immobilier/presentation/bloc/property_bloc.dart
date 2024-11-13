import 'dart:io';
import 'package:convergeimmob/features/immobilier/data/models/location_model.dart';
import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/features/immobilier/domain/usecases/add_property_usecase.dart';
import 'package:convergeimmob/features/immobilier/domain/usecases/fetch_allproperties_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'property_event.dart';
import 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final AddPropertyUseCase addPropertyUseCase;
  final FetchAllPropertiesUseCase fetchAllPropertiesUseCase;
  PropertyModel property = PropertyModel();

  List<File> listImages = [];
  File pdfFile = File('');
  int counterBathrooms = 0;

  PropertyBloc({
    required this.addPropertyUseCase,
    required this.fetchAllPropertiesUseCase,
    required this.property,
  }) : super(PropertyInitial()) {
    // Event Handlers
    on<SelectPropertyType>(_onSelectPropertyType);
    on<SelectLocation>(_onSelectLocation);
    on<SelectTitle>(_onSelectTitle);
    on<SelectDescription>(_onSelectDescription);
    on<SelectPrice>(_onSelectPrice);
    on<TypePrice>(_onSelectType);
    on<SelectDuration>(_onSelectDuration);
    on<SelectAmenity>(_onSelectAmenity);
    on<UploadPhoto>(_onUploadPhoto);
    on<UploadPdfFile>(_onUploadPdf);
    on<AddProperty>(_onAddProperty);
    on<FetchAllProperty>(_onFetchAllProperties);
    on<IncrementBedrooms>(_onIncrementBedrooms);
    on<DecrementBedrooms>(_onDecrementBedrooms);
    on<IncrementBeds>(_onIncrementBeds);
    on<DecrementBeds>(_onDecrementBeds);
    on<IncrementBathroomsCounter>(_onIncrementBathroomsCounter);
    on<DecrementBathroomsCounter>(_onDecrementBathroomsCounter);
  }

  void _onSelectPropertyType(
      SelectPropertyType event, Emitter<PropertyState> emit) {
    property = property.copyWith(category: event.index.toString());
    emit(PropertyTypeSelected(event.index));
  }

  void _onSelectLocation(SelectLocation event, Emitter<PropertyState> emit) {
    property = property.copyWith(
      location: LocationModel(
        address: event.selectedLocation.address,
        longitude: event.selectedLocation.longitude,
        latitude: event.selectedLocation.latitude,
      ),
    );
    emit(PropertyUpdated(property));
  }

  void _onSelectTitle(SelectTitle event, Emitter<PropertyState> emit) {
    property = property.copyWith(title: event.title);
    emit(PropertyUpdatedState(property: property));
  }

  void _onSelectDescription(
      SelectDescription event, Emitter<PropertyState> emit) {
    property = property.copyWith(description: event.description);
    emit(PropertyUpdatedState(property: property));
  }

  void _onSelectPrice(SelectPrice event, Emitter<PropertyState> emit) {
    property = property.copyWith(price: double.tryParse(event.price) ?? 0.0);
    emit(PropertyUpdatedState(property: property));
  }

  void _onSelectType(TypePrice event, Emitter<PropertyState> emit) {
    property = property.copyWith(immobStatus: event.type);
    emit(PropertyUpdatedState(property: property));
  }

  void _onSelectDuration(SelectDuration event, Emitter<PropertyState> emit) {
    property = property.copyWith(paymentInterval: event.duration);
    emit(PropertyUpdatedState(property: property));
  }

  // void _onSelectAmenity(SelectAmenity event, Emitter<PropertyState> emit) {
  //   final updatedAmenities = Map<String, bool>.from(
  //     property.amenities ?? {}, // Default to an empty map if amenities is null
  //   );
  //
  //   updatedAmenities[event.amenityName] = event.isSelected;
  //   property = property.copyWith(amenities: updatedAmenities);
  //   emit(AmenitiesSelectionUpdated(updatedAmenities));
  // }

  void _onSelectAmenity(SelectAmenity event, Emitter<PropertyState> emit) {
    // Initialize amenities as an empty list if it is null
    final updatedAmenities = property.amenities?.toList() ?? [];

    // Add or remove the selected amenity based on the event
    if (event.isSelected) {
      // Add the amenity if it's selected and not already in the list
      if (!updatedAmenities.contains(event.amenityName)) {
        updatedAmenities.add(event.amenityName);
      }
    } else {
      // Remove the amenity if it's deselected
      updatedAmenities.remove(event.amenityName);
    }

    // Update the property with the new amenities list
    property = property.copyWith(amenities: updatedAmenities);

    // Emit the updated state with the new amenities list
    emit(AmenitiesSelectionUpdated(updatedAmenities));
  }

  void _onUploadPhoto(UploadPhoto event, Emitter<PropertyState> emit) {
    final currentPhotoPaths = property.listingPhotoPaths ?? [];

    if (event.index < currentPhotoPaths.length) {
      currentPhotoPaths[event.index] = event.filePath;
    } else {
      currentPhotoPaths.add(event.filePath);
    }

    listImages.add(event.imageFile);
    property = property.copyWith(listingPhotoPaths: currentPhotoPaths);

    emit(PhotosUploaded(Map<int, String>.from(currentPhotoPaths.asMap())));
  }

  void _onUploadPdf(UploadPdfFile event, Emitter<PropertyState> emit) {
    // Set the pdfFile to the provided file path
    pdfFile = File(event.filePath);

    // Update the property model with the path of the PDF file
    property = property.copyWith(pdfFile: pdfFile.path);

    // Emit the updated state with the new PDF file path
    emit(PdfFileUploaded(pdfFile.path));
    emit(PropertyUpdatedState(property: property));
  }

  Future<void> _onAddProperty(
      AddProperty event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    try {
      final result =
          await addPropertyUseCase.call(property, listImages, pdfFile);
      emit(PropertyLoaded(result));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> _onFetchAllProperties(
      FetchAllProperty event, Emitter<PropertyState> emit) async {
    emit(ListPropertyLoading());
    try {
      final result = await fetchAllPropertiesUseCase.call();
      if (result != null && result.isNotEmpty) {
        emit(ListPropertyLoaded(result));
      } else {
        emit(PropertyEmpty()); // A state to handle when there's no data
      }
    } catch (error) {
      emit(PropertyError(error.toString()));
    }
  }

  // void _onFetchAllProperties(FetchAllProperty event, Emitter<PropertyState> emit) async {
  //   try {
  //     emit(PropertyLoading()); // Emitting a loading state before fetching data
  //
  //     List<PropertyModel> properties = await fetchAllProperty();
  //
  //     emit(PropertyLoaded(properties)); // Emitting a loaded state with fetched properties
  //   } catch (error) {
  //     emit(PropertyError(error.toString())); // Emitting an error state in case of failure
  //   }
  // }

  // Event handler for incrementing bedrooms
  void _onIncrementBedrooms(
      IncrementBedrooms event, Emitter<PropertyState> emit) {
    property = property.copyWith(bedroomCount: property.bedroomCount! + 1);
    emit(PropertyUpdated(property));
  }

  // Event handler for decrementing bedrooms
  void _onDecrementBedrooms(
      DecrementBedrooms event, Emitter<PropertyState> emit) {
    if (property.bedroomCount! > 0) {
      property = property.copyWith(bedroomCount: property.bedroomCount! - 1);
      emit(PropertyUpdated(property));
    }
  }

  // Event handler for incrementing beds
  void _onIncrementBeds(IncrementBeds event, Emitter<PropertyState> emit) {
    property = property.copyWith(bedCount: property.bedCount! + 1);
    emit(PropertyUpdated(property));
  }

  // Event handler for decrementing beds
  void _onDecrementBeds(DecrementBeds event, Emitter<PropertyState> emit) {
    if (property.bedCount! > 0) {
      property = property.copyWith(bedCount: property.bedCount! - 1);
      emit(PropertyUpdated(property));
    }
  }

  // Event handler for incrementing bathrooms
  void _onIncrementBathroomsCounter(
      IncrementBathroomsCounter event, Emitter<PropertyState> emit) {
    counterBathrooms++;
    property = property.copyWith(bathroomCount: counterBathrooms);
    emit(PropertyUpdated(property));
  }

  // Event handler for decrementing bathrooms
  void _onDecrementBathroomsCounter(
      DecrementBathroomsCounter event, Emitter<PropertyState> emit) {
    if (counterBathrooms > 0) {
      counterBathrooms--;
      property = property.copyWith(bathroomCount: counterBathrooms);
      emit(PropertyUpdated(property));
    }
  }
}
