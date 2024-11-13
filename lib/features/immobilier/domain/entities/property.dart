import 'package:convergeimmob/features/immobilier/data/models/location_model.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';

class Property {
  final String? creator;
  final String? category;
  final String? streetAddress;
  final String? aptSuite;
  final String? city;
  final String? province;
  final String? country;
  final int? guestCount;
  final List<double>? position;
  final LocationModel? location;
  final int? bedroomCount;
  final int? bedCount;
  final int? bathroomCount;
  final List<String>? amenities;
  final String? panoImg;
  final List<String>? listingPhotoPaths;
  final String? pdfFile;
  final String? secondPdfFile;
  final String? title;
  final String? description;
  final String? highlight;
  final String? highlightDesc;
  final double? price;
  final String? immobStatus;
  final String? paymentInterval;
  final bool? VRTour;

  Property({
    this.creator,
    this.category,
    this.streetAddress,
    this.aptSuite,
    this.city,
    this.province,
    this.country,
    this.guestCount,
    this.position,
    this.location,
    this.bedroomCount,
    this.bedCount,
    this.bathroomCount,
    this.amenities,
    this.panoImg,
    this.listingPhotoPaths,
    this.pdfFile,
    this.secondPdfFile,
    this.title,
    this.description,
    this.highlight,
    this.highlightDesc,
    this.price,
    this.immobStatus,
    this.paymentInterval,
    this.VRTour,
  });
}
