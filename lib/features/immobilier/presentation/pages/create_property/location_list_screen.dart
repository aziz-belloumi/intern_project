import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/location.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/services/location_services.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  // Move locations to the State class
  List<Location?> locations = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: AppBackground(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      child: Column(
        children: [
          AppTextField(
            obscureText: false,
            icon: Icons.location_on,
            text: "Your Location",
            onChanged: (value) async {
              // Fetch locations and update the state
              List<Location?> fetchedLocations =
                  await getCoordinateFromAddress(value);

              setState(() {
                locations = fetchedLocations;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];

                if (location == null) {
                  return const ListTile(
                    title: Text('Unknown location'),
                  );
                }

                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      if (location != null) {
                        BlocProvider.of<PropertyBloc>(context)
                            .add(SelectLocation(location));
                        Get.offNamedUntil('/locationProperty', (route) => route.isFirst);
                        print(BlocProvider.of<PropertyBloc>(context).property.toJson());
                        // print('Selected Location: ${location.address}');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.gNavBgColor.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          SizedBox(
                              width: size.width * 0.6,
                              child: Text('${location.address}')),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          BlocListener<PropertyBloc, PropertyState>(
            listener: (context, state) {
              if (state is LocationSelected) {
                // Print the selected location
                print(
                    'Selecteds Location: Lat: ${state.selectedLocation.latitude}, Lng: ${state.selectedLocation.longitude}');
              }
            },
            child: Container(), // Your widget tree here
          )
        ],
      ),
    ));
  }
}
