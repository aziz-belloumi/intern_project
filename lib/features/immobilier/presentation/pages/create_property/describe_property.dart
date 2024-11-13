import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DescribePropertyScreen extends StatelessWidget {
  DescribePropertyScreen({super.key});

  List describePropertyList = [
    {"icon": Icons.home, "title": "House"},
    {"icon": Icons.apartment, "title": "Apartment"},
    {"icon": Icons.villa, "title": "Villa"},
    {"icon": Icons.house_sharp, "title": "Townhouse"},
    {"icon": Icons.scatter_plot, "title": "Residential Plot"},
    {"icon": Icons.house_siding, "title": "Residential Building"},
    {"icon": Icons.maps_home_work_outlined, "title": "Office"},
    {"icon": Icons.shop, "title": "Shop"},
    {"icon": Icons.holiday_village, "title": "Commercial Villa"},
    {"icon": Icons.shower_outlined, "title": "Showroom"},
    {"icon": Icons.map, "title": "Commercial Plot"},
    {"icon": Icons.apartment_sharp, "title": "Commercial Building"},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: BlocListener<PropertyBloc, PropertyState>(
        listener: (context, state) {
          if (state is PropertyLoaded) {
            Get.snackbar('Success', 'Property added successfully!');
          } else if (state is PropertyError) {
            Get.snackbar('Error', state.message);
          }
        },
        child: BlocBuilder<PropertyBloc, PropertyState>(
          builder: (context, state) {
            int selectedIndex = -1;
            if (state is PropertyTypeSelected) {
              selectedIndex = state.selectedIndex;
            }

            return Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 64,
                bottom: 64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Which of the following best describes your property?",
                    textAlign: TextAlign.center,
                    style: AppStyles.smallTitle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: describePropertyList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                        (orientation == Orientation.portrait) ? 3 : 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<PropertyBloc>()
                                .add(SelectPropertyType(index));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01,
                              vertical: size.width * 0.01,
                            ),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8)),
                                color:  selectedIndex == index
                                    ? AppColors.bluebgNavItem.withOpacity(0.3)
                                    : AppColors
                                    .white,
                                border: Border.all(
                                  width: 2,
                                  color: selectedIndex == index
                                      ? AppColors.bluebgNavItem
                                      : AppColors
                                      .greyDescribePropertyItem,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01,
                                vertical: size.width * 0.01,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    describePropertyList[index]['icon'],
                                    color: selectedIndex == index
                                        ? AppColors.bluebgNavItem
                                        : AppColors
                                        .greyDescribePropertyItem,
                                  ),
                                  Text(
                                    describePropertyList[index]['title']
                                        .toString(),
                                    style: AppStyles.smallTitle(
                                      color: selectedIndex == index
                                          ? AppColors.bluebgNavItem
                                          : AppColors
                                          .greyDescribePropertyItem,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                          child: const Text('Back'),
                        ),
                        AppButton(
                          onPressed: () {
                            // Ensure a property type is selected
                            if (selectedIndex != -1) {
                              Get.toNamed('locationProperty');
                            } else {
                              Get.snackbar('Error', 'Please select a property type.');
                            }
                          },
                          width: size.width * 0.3,
                          text: 'Continue',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
