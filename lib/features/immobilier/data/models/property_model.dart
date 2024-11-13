import 'package:convergeimmob/features/immobilier/data/models/location_model.dart';

class PropertyModel {
  final String? creator;
  final String? category;
  final String? streetAddress;
  final String? aptSuite;
  final String? city;
  final String? province;
  final String? country;
  final int? guestCount;
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

  PropertyModel({
    this.creator,
    this.category,
    this.streetAddress,
    this.aptSuite,
    this.city,
    this.province,
    this.country,
    this.guestCount,
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

  PropertyModel copyWith({
    String? creator,
    String? category,
    String? streetAddress,
    String? aptSuite,
    String? city,
    String? province,
    String? country,
    int? guestCount,
    LocationModel? location,
    int? bedroomCount,
    int? bedCount,
    int? bathroomCount,
    List<String>? amenities,
    String? panoImg,
    List<String>? listingPhotoPaths,
    String? pdfFile,
    String? secondPdfFile,
    String? title,
    String? description,
    String? highlight,
    String? highlightDesc,
    double? price,
    String? immobStatus,
    String? paymentInterval,
    bool? VRTour,
  }) {
    return PropertyModel(
      creator: creator ?? this.creator,
      category: category ?? this.category,
      streetAddress: streetAddress ?? this.streetAddress,
      aptSuite: aptSuite ?? this.aptSuite,
      city: city ?? this.city,
      province: province ?? this.province,
      country: country ?? this.country,
      guestCount: guestCount ?? this.guestCount,
      location: location ?? this.location,
      bedroomCount: bedroomCount ?? this.bedroomCount,
      bedCount: bedCount ?? this.bedCount,
      bathroomCount: bathroomCount ?? this.bathroomCount,
      amenities: amenities ?? this.amenities,
      panoImg: panoImg ?? this.panoImg,
      listingPhotoPaths: listingPhotoPaths ?? this.listingPhotoPaths,
      pdfFile: pdfFile ?? this.pdfFile,
      secondPdfFile: secondPdfFile ?? this.secondPdfFile,
      title: title ?? this.title,
      description: description ?? this.description,
      highlight: highlight ?? this.highlight,
      highlightDesc: highlightDesc ?? this.highlightDesc,
      price: price ?? this.price,
      immobStatus: immobStatus ?? this.immobStatus,
      paymentInterval: paymentInterval ?? this.paymentInterval,
      VRTour: VRTour ?? this.VRTour,
    );
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      creator: json['creator'],
      category: json['category'],
      streetAddress: json['streetAddress'],
      aptSuite: json['aptSuite'],
      city: json['city'],
      province: json['province'],
      country: json['country'],
      guestCount: json['guestCount'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      bedroomCount: json['bedroomCount'],
      bedCount: json['bedCount'],
      bathroomCount: json['bathroomCount'],
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      panoImg: json['panoImg'],
      listingPhotoPaths: (json['listingPhotoPaths'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      pdfFile: json['pdfFile'],
      secondPdfFile: json['secondPdfFile'],
      title: json['title'],
      description: json['description'],
      highlight: json['highlight'],
      highlightDesc: json['highlightDesc'],
      price: (json['price'] as num?)?.toDouble(),
      immobStatus: json['immobStatus'],
      paymentInterval: json['paymentInterval'],
      VRTour: json['VRTour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creator': creator,
      'category': category,
      'streetAddress': streetAddress,
      'aptSuite': aptSuite,
      'city': city,
      'province': province,
      'country': country,
      'guestCount': guestCount,
      'location': location?.toJson(),
      'bedroomCount': bedroomCount,
      'bedCount': bedCount,
      'bathroomCount': bathroomCount,
      'amenities': amenities,
      'panoImg': panoImg,
      'listingPhotoPaths': listingPhotoPaths,
      'pdfFile': pdfFile,
      'secondPdfFile': secondPdfFile,
      'title': title,
      'description': description,
      'highlight': highlight,
      'highlightDesc': highlightDesc,
      'price': price,
      'immobStatus': immobStatus,
      'paymentInterval': paymentInterval,
      'VRTour': VRTour,
    };
  }
}
