import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';

class LocationProperty extends StatelessWidget {
  const LocationProperty({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Text(
                  "Where is your property located?",
                  textAlign: TextAlign.center,
                  style: AppStyles.smallTitle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              BlocBuilder<PropertyBloc, PropertyState>(
                builder: (context, state) {
                  if (state is PropertyLoading) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Display loading indicator
                  } else if (state is PropertyUpdated) {
                    final property = state.property;
                    String locationText = "Your Location";

                    if (property.location != null) {
                      locationText = property.location!.address ?? locationText;
                    }

                    return GestureDetector(
                      onTap: () async {
                        final selectedLocation =
                            await Get.toNamed('locationListScreen')
                                as Location?;
                        if (selectedLocation != null) {
                          BlocProvider.of<PropertyBloc>(context)
                              .add(SelectLocation(selectedLocation));
                        }
                      },
                      child: AppTextField(
                        enabled: false,
                        obscureText: false,
                        icon: Icons.location_on,
                        text: locationText,
                        //borderColor: AppColors.black,
                      ),
                    );
                  } else {
                    String locationText = "Your Location";

                    return GestureDetector(
                      onTap: () async {
                        final selectedLocation =
                            await Get.toNamed('locationListScreen')
                                as Location?;
                        if (selectedLocation != null) {
                          BlocProvider.of<PropertyBloc>(context)
                              .add(SelectLocation(selectedLocation));
                        }
                      },
                      child: AppTextField(
                        enabled: false,
                        obscureText: false,
                        icon: Icons.location_on,
                        text: locationText,
                      ),
                    ); // Visible default widget
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              BlocBuilder<PropertyBloc, PropertyState>(
                builder: (context, state) {
                  String locationText = "Your Location";
                  latLng.LatLng mapCenter =
                      latLng.LatLng(52.377956, 4.89707); // Default location

                  if (state is PropertyUpdated &&
                      state.property.location != null) {
                    locationText =
                        state.property.location!.address ?? locationText;
                    mapCenter = latLng.LatLng(
                        state.property.location!.latitude!,
                        state.property.location!.longitude!);
                    print('Map Center Updated: $mapCenter');
                  }

                  return SizedBox(
                    height: size.height * 0.5,
                    width: size.width,
                    child: FlutterMap(
                      options: MapOptions(
                        center: mapCenter,
                        zoom: 10.0,
                        minZoom: 3.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaG91c3NlbWVkZGluZW1iYXJlayIsImEiOiJjbGpzbjZkdWMwYzZsM2ZuMGxtNDN6dTMzIn0.jpXIKj6gqtJZNtr9BaiyNw',
                          additionalOptions: {
                            'accessToken':
                                'pk.eyJ1IjoiaG91c3NlbWVkZGluZW1iYXJlayIsImEiOiJjbGpzbjZkdWMwYzZsM2ZuMGxtNDN6dTMzIn0.jpXIKj6gqtJZNtr9BaiyNw',
                            'id': 'mapbox.streets'
                          },
                        ),
                        if (state is PropertyUpdated &&
                            state.property.location != null)
                          MarkerLayer(
                            markers: [
                              // Marker(
                              //   width: 20.0,
                              //   height: 20.0,
                              //   point: latLng.LatLng(
                              //     state.property.location!.latitude!,
                              //     state.property.location!.longitude!,
                              //   ),
                              //   builder: (context) => Container(
                              //     child: Icon(
                              //       Icons.location_on,
                              //       color: Colors.red,
                              //       size: 30,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
              Spacer(),
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
                        child: Text('Back')),
                    AppButton(
                      onPressed: () {
                        Get.toNamed('bedroomDetailProperty');
                        // context.read<PropertyBloc>().add(AddProperty(property));
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
      ),
    );
  }
}
