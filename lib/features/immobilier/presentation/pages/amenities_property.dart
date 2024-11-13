import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AmenitiesProperty extends StatelessWidget {
  AmenitiesProperty({super.key});

  final List<Map<String, dynamic>> amenitiesList = [
    {"icon": Icons.security, "label": "Security Features"},
    {"icon": Icons.tv, "label": "TV"},
    {"icon": Icons.hot_tub, "label": "Hot Tub"},
    {"icon": Icons.wifi, "label": "Wifi"},
    {"icon": Icons.sports_gymnastics, "label": "Gym"},
    {"icon": Icons.pets, "label": "Pet-Friendly"},
    {"icon": Icons.air, "label": "Air Conditioning"},
    {"icon": Icons.pool, "label": "Pool"},
    {"icon": Icons.elevator, "label": "Elevator"},
    {"icon": Icons.kitchen, "label": "Kitchen"},
    {
      "icon": Icons.local_laundry_service_rounded,
      "label": "Laundry Facilities"
    },
    {"icon": Icons.local_parking, "label": "Parking"},
    {"icon": Icons.camera_outdoor, "label": "Outdoor Space"},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                "Let travelers know what amenities your property offers",
                textAlign: TextAlign.center,
                style: AppStyles.smallTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Wrap(
              spacing: size.width * 0.04,
              runSpacing: size.width * 0.04,
              alignment: WrapAlignment.center,
              children: amenitiesList.map((amenity) {
                return BlocBuilder<PropertyBloc, PropertyState>(
                  builder: (context, state) {


                    bool isSelected = state is AmenitiesSelectionUpdated
                        ? (state.selectedAmenities.contains(amenity['label']))
                        : false;

                    return GestureDetector(
                      onTap: () {
                        context.read<PropertyBloc>().add(
                              SelectAmenity(
                                amenityName: amenity['label'],
                                isSelected: !isSelected,
                              ),
                            );
                      },
                      child: Container(
                        height: size.width * 0.2,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.bluebgNavItem.withOpacity(0.3)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: isSelected
                                ? AppColors.bluebgNavItem
                                : AppColors.greyDescribePropertyItem,
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              amenity['icon'] as IconData,
                              color:
                                  isSelected ? AppColors.black : AppColors.grey,
                            ),
                            Text(
                              amenity['label'].toString(),
                              style: AppStyles.smallTitle(
                                color: isSelected
                                    ? AppColors.black
                                    : AppColors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Back'),
                  ),
                  AppButton(
                    onPressed: () {
                      Get.toNamed('uploadFilesScreen');
                    },
                    width: size.width * 0.3,
                    text: 'Continue',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
