import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/features/authServices/bloc/log_out_cubit.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/shared/app_textfield.dart';

import 'features/authServices/bloc/global_state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PropertyBloc>(context).add(FetchAllProperty());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<LogOutCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthInitial) {
            Get.offAllNamed('/login');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.width * 0.02,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              height: size.height * 0.06,
                              obscureText: false,
                              width: size.width * 0.75,
                              icon: Icons.search,
                              iconColor: AppColors.black.withOpacity(0.5),
                              text: "Search",
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RoutesClass.filterScreen);
                              },
                              child: Container(
                                height: size.height * 0.06,
                                width: size.height * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                    color: AppColors.black.withOpacity(0.5),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: AppColors.black.withOpacity(0.5),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: size.height * 0.48,
                          child: BlocBuilder<PropertyBloc, PropertyState>(
                            builder: (context, state) {
                              if (state is ListPropertyLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is ListPropertyLoaded) {
                                final properties = state.properties;

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: properties.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final property = properties[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed('detail_property',
                                            arguments: property);
                                      },
                                      child: Container(
                                        height: size.height * 0.45,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            property.listingPhotoPaths!
                                                    .isNotEmpty
                                                ? SizedBox(
                                                    width: size.width * 0.5,
                                                    height: size.height * 0.3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        "${local}/${property.listingPhotoPaths![0]}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(width: size.width * 0.01),
                                            Row(
                                              children: [
                                                Text(
                                                  property.title ??
                                                      property
                                                          .listingPhotoPaths![0],
                                                  style: AppStyles.title(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: size.width * 0.01),
                                            Row(
                                              children: [
                                                Icon(Icons.bed,
                                                    size: 16,
                                                    color: AppColors.grey),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                Text(
                                                    "${property.bedCount ?? 0}",
                                                    style:
                                                        AppStyles.smallTitle()),
                                                SizedBox(
                                                    width: size.width * 0.02),
                                                Icon(Icons.bathtub_outlined,
                                                    size: 16,
                                                    color: AppColors.grey),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                Text(
                                                    "${property.bathroomCount ?? 0}",
                                                    style:
                                                        AppStyles.smallTitle()),
                                              ],
                                            ),
                                            SizedBox(height: size.width * 0.01),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,
                                                    size: 16,
                                                    color: AppColors.grey),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                Text(
                                                    property.location
                                                            ?.address ??
                                                        "Place",
                                                    style:
                                                        AppStyles.smallTitle()),
                                              ],
                                            ),
                                            SizedBox(height: size.width * 0.01),
                                            Row(
                                              children: [
                                                Text("\$${property.price ?? 0}",
                                                    style: AppStyles.title()),
                                              ],
                                            ),
                                            SizedBox(height: size.width * 0.01),
                                            Text("Per month",
                                                style: AppStyles.smallTitle()),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is PropertyError) {
                                return Center(
                                    child: Text('Failed to load properties'));
                              } else {
                                return Center(
                                    child: Text('No properties available'));
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          child: Text(
                            "Best Matches For You",
                            style: AppStyles.title(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<PropertyBloc, PropertyState>(
                              builder: (context, state) {
                                if (state is ListPropertyLoading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (state is ListPropertyLoaded) {
                                  final properties = state.properties;

                                  return Column(
                                    children: properties.map((property) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed('detail_property',
                                              arguments: property);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              property.listingPhotoPaths!
                                                      .isNotEmpty
                                                  ? SizedBox(
                                                      width: size.width * 0.9,
                                                      height: size.height * 0.3,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          "${local}/${property.listingPhotoPaths![0]}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Row(
                                                children: [
                                                  Text(
                                                      property.title ??
                                                          "Property Name",
                                                      style: AppStyles.title()),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Row(
                                                children: [
                                                  Icon(Icons.bed,
                                                      size: 16,
                                                      color: AppColors.grey),
                                                  SizedBox(
                                                      width: size.width * 0.01),
                                                  Text(
                                                      "${property.bedCount ?? 0}",
                                                      style: AppStyles
                                                          .smallTitle()),
                                                  SizedBox(
                                                      width: size.width * 0.02),
                                                  Icon(Icons.bathtub_outlined,
                                                      size: 16,
                                                      color: AppColors.grey),
                                                  SizedBox(
                                                      width: size.width * 0.01),
                                                  Text(
                                                      "${property.bathroomCount ?? 0}",
                                                      style: AppStyles
                                                          .smallTitle()),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Row(
                                                children: [
                                                  Icon(Icons.location_on,
                                                      size: 16,
                                                      color: AppColors.grey),
                                                  SizedBox(
                                                      width: size.width * 0.01),
                                                  Text(
                                                      property.location
                                                              ?.address ??
                                                          "Place",
                                                      style: AppStyles
                                                          .smallTitle()),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Row(
                                                children: [
                                                  Text(
                                                      "\$${property.price ?? 0}",
                                                      style: AppStyles.title()),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Text("Per month",
                                                  style:
                                                      AppStyles.smallTitle()),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else if (state is PropertyError) {
                                  return Center(
                                      child: Text('Failed to load properties'));
                                } else {
                                  return Center(
                                      child: Text('No properties available'));
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 1, // Since we're only using one list for vertical items
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: size.width * 0.3,
              right: size.width * 0.3,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed("map_screen");
                },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.bluePrimaryHigher),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.map_outlined,
                      color: AppColors.white,
                    ),
                    Text(
                      "Map View",
                      style: AppStyles.smallTitleWhite(
                          fontSize: size.width * 0.038),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.toNamed("create_property");
      //   },
      //   backgroundColor: AppColors.bluePrimaryHigher,
      //   child: const Icon(Icons.add, color: AppColors.white),
      // ),
    );
  }
}
