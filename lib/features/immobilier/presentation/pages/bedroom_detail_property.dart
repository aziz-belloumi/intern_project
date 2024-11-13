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

class BedroomDetailProperty extends StatelessWidget {
  const BedroomDetailProperty({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                "Provide Details About Your Property",
                textAlign: TextAlign.center,
                style: AppStyles.smallTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(flex: 3),
            BlocBuilder<PropertyBloc, PropertyState>(
              builder: (context, state) {
                if (state is PropertyUpdated) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bedrooms",
                            style: AppStyles.title(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Spacer(),
                          buildCounterButton(
                            size,
                            Icons.remove,
                            () {
                              context
                                  .read<PropertyBloc>()
                                  .add(DecrementBedrooms());
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          SizedBox(
                            width: size.width * 0.09,
                            child: Text(
                              state.property.bedroomCount.toString(),
                              style: AppStyles.title(
                                  fontWeight: FontWeight.w500, fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          buildCounterButton(
                            size,
                            Icons.add,
                            () {
                              context
                                  .read<PropertyBloc>()
                                  .add(IncrementBedrooms());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      buildSeparator(size),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Beds",
                            style: AppStyles.title(
                                fontWeight: FontWeight.w500, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          buildCounterButton(
                            size,
                            Icons.remove,
                            () {
                              context.read<PropertyBloc>().add(DecrementBeds());
                            },
                          ),
                          SizedBox(width: size.width * 0.04),
                          SizedBox(
                            width: size.width * 0.09,
                            child: Text(
                              state.property.bedCount.toString(),
                              style: AppStyles.title(
                                  fontWeight: FontWeight.w500, fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: size.width * 0.04),
                          buildCounterButton(
                            size,
                            Icons.add,
                            () {
                              context.read<PropertyBloc>().add(IncrementBeds());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      buildSeparator(size),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bathrooms",
                            style: AppStyles.title(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const Spacer(),
                          buildCounterButton(size, Icons.remove, () {
                            context
                                .read<PropertyBloc>()
                                .add(DecrementBathroomsCounter());
                          }),
                          SizedBox(width: size.width * 0.04),
                          SizedBox(
                            width: size.width * 0.09,
                            child: Text(
                              state.property.bathroomCount.toString(),
                              // This should be connected to Bloc state when you implement it
                              style: AppStyles.title(
                                  fontWeight: FontWeight.w500, fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: size.width * 0.04),
                          buildCounterButton(size, Icons.add, () {
                            context
                                .read<PropertyBloc>()
                                .add(IncrementBathroomsCounter());
                          }),
                        ],
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),

            const Spacer(flex: 3),
            // Navigation buttons
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
                      Get.toNamed('amenitiesProperty');
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

  Widget buildCounterButton(
      Size size, IconData icon, void Function()? function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: size.width * 0.07,
        height: size.width * 0.07,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1),
        ),
        child: Center(
          child: Icon(icon, size: 16),
        ),
      ),
    );
  }

  Widget buildSeparator(Size size) {
    return Container(
      width: size.width * 0.9,
      height: size.width * 0.003,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
