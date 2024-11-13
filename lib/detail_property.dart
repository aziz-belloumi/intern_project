import 'package:carousel_slider/carousel_slider.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/data/models/property_model.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;

class DetailProperty extends StatefulWidget {
  DetailProperty({super.key});

  @override
  State<DetailProperty> createState() => _DetailPropertyState();
}

class _DetailPropertyState extends State<DetailProperty> {
  CarouselController buttonCarouselController = CarouselController();

  final property = Get.arguments as PropertyModel;

  @override
  void initState() {
    print(property.toJson());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.9,
              width: size.width,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: size.height * 0.33,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              "${local}/${property.listingPhotoPaths![0]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 16, // Adjust as needed
                            left: size.width * 0.35,
                            right: size.width * 0.35,
                            child: AppButton(
                              text: "VR View",
                              width: size.width * 0.2,
                              height: size.height * 0.04,
                              onPressed: () {
                                Get.toNamed('view360_screen');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                  height: size.height * 0.07,
                                  width: size.width * 0.17,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      child: Image.network(
                                          "${local}/${property.listingPhotoPaths![0]}",
                                          fit: BoxFit.cover))),
                              SizedBox(
                                  height: size.height * 0.07,
                                  width: size.width * 0.17,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      child: Image.network(
                                          "${local}/${property.listingPhotoPaths![1]}",
                                          fit: BoxFit.cover))),
                              SizedBox(
                                  height: size.height * 0.07,
                                  width: size.width * 0.17,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      child: Image.network(
                                          "${local}/${property.listingPhotoPaths![2]}",
                                          fit: BoxFit.cover))),
                              SizedBox(
                                  height: size.height * 0.07,
                                  width: size.width * 0.17,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      child: Image.network(
                                          "${local}/${property.listingPhotoPaths![4]}",
                                          fit: BoxFit.cover))),
                              SizedBox(
                                  height: size.height * 0.07,
                                  width: size.width * 0.17,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      child: Image.network(
                                          "${local}/${property.listingPhotoPaths![3]}",
                                          fit: BoxFit.cover))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property.title.toString(),
                                    style: AppStyles.smallTitle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("\$ ${property.price}",
                                          style: AppStyles.smallTitle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Text(
                                        "Per Month",
                                        style: AppStyles.smallTitle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.bed,
                                      size: 16, color: AppColors.grey),
                                  SizedBox(width: size.width * 0.01),
                                  Text("${property.bedCount}",
                                      style: AppStyles.smallTitle()),
                                  SizedBox(width: size.width * 0.02),
                                  Icon(Icons.bathtub_outlined,
                                      size: 16, color: AppColors.grey),
                                  SizedBox(width: size.width * 0.01),
                                  Text("${property.bathroomCount}",
                                      style: AppStyles.smallTitle()),
                                  SizedBox(width: size.width * 0.01),
                                  Icon(Icons.view_comfy_alt_rounded,
                                      size: 16, color: AppColors.grey),
                                  SizedBox(width: size.width * 0.01),
                                  Text("${250} sqrt",
                                      style: AppStyles.smallTitle()),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: AppColors.grey),
                                  SizedBox(width: size.width * 0.01),
                                  Text(property.location?.latitude != null ? property.location!.latitude.toString(): "Place",
                                      style: AppStyles.smallTitle()),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.9,
                          height: size.height * 0.001,
                          decoration: BoxDecoration(color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                width: size.width,
                                child: Text(
                                  "Description",
                                  style: AppStyles.smallTitle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                width: size.width,
                                child: Text(
                                  property.description.toString(),
                                  style: AppStyles.smallTitle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.9,
                          height: size.height * 0.001,
                          decoration: BoxDecoration(color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              Text(
                                "Where you will be",
                                style: AppStyles.smallTitle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                height: size.height * 0.4,
                                width: size.width,
                                child: FlutterMap(
                                  options: MapOptions(
                                    center: latLng.LatLng(
                                      54,
                                      10,
                                    ),
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
                                    // if (state is PropertyUpdated &&
                                    //     state.property.location != null)
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          width: 20.0,
                                          height: 20.0,
                                          point: latLng.LatLng(
                                            54,
                                            10,
                                          ),
                                          builder: (context) => Container(
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.9,
                          height: size.height * 0.001,
                          decoration: BoxDecoration(color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              Text(
                                "Meet the owner",
                                style: AppStyles.smallTitle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Container(
                                constraints: BoxConstraints(
                                  minHeight: size.height * 0.2,
                                ),
                                width: size.width * 0.9,
                                padding: EdgeInsets.all(16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.grey.withOpacity(0.1),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.08,
                                          width: size.height * 0.08,
                                          child: ClipOval(
                                            child: Image.network(
                                                "assets/images/appart.jpg",
                                                fit: BoxFit.fill),
                                            // borderRadius:
                                            //     BorderRadius.all(Radius.circular(60)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Jeremiah Green",
                                          style: AppStyles.smallTitle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Tunisia",
                                          style: AppStyles.smallTitle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: size.width * 0.004,
                                      height: size.height * 0.15,
                                      decoration:
                                      BoxDecoration(color: AppColors.black),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "198",
                                          style: AppStyles.smallTitle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black),
                                        ),
                                        Text(
                                          "Reviews",
                                          style: AppStyles.smallTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: size.width * 0.22,
                                          height: size.height * 0.002,
                                          decoration: BoxDecoration(
                                              color: AppColors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "4.5",
                                          style: AppStyles.smallTitle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black),
                                        ),
                                        Text(
                                          "Rating",
                                          style: AppStyles.smallTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: size.width * 0.22,
                                          height: size.height * 0.002,
                                          decoration: BoxDecoration(
                                              color: AppColors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "4.5",
                                          style: AppStyles.smallTitle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black),
                                        ),
                                        Text(
                                          "Rating",
                                          style: AppStyles.smallTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              AppButton(
                                  width: size.width * 0.9,
                                  text: "Get in touch with the owner",
                                  onPressed: () {}),
                              SizedBox(height: size.height * 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: size.height * 0.1,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    height: size.height * 0.06,
                    width: size.width * 0.45,
                    text: "Rent Now",
                    onPressed: () {},
                  ),
                  AppButton(
                    height: size.height * 0.06,
                    width: size.width * 0.45,
                    text: "Request a Tour",
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
