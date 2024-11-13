import 'dart:io';
import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadsPhotosScreen extends StatelessWidget {
  const UploadsPhotosScreen({super.key});

  Future<void> _pickImage(BuildContext context, int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        File imageFile = File(filePath);
        BlocProvider.of<PropertyBloc>(context).add(UploadPhoto(
            index: index, filePath: filePath, imageFile: imageFile));
      }
    }
  }

  Widget _buildImageContainer(
      BuildContext context, int index, Size size, width) {
    return GestureDetector(
      onTap: () {
        _pickImage(context, index);
      },
      child: Container(
        width: width,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: DottedBorder(
          color: AppColors.greyDescribePropertyItem,
          strokeWidth: 2,
          dashPattern: [6, 3],
          radius: Radius.circular(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: BlocBuilder<PropertyBloc, PropertyState>(
              builder: (context, state) {
                if (state is PhotosUploaded &&
                    state.photos.containsKey(index)) {
                  return Image.file(
                    File(state.photos[index]!),
                    fit: BoxFit.cover,
                    // Ensures the image covers the entire space
                    width: double.infinity,
                    height: double.infinity,
                  );
                }
                return Center(
                  child: Image.asset(
                    "assets/icons/camera.png",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                "Upload Photos of Your Property",
                textAlign: TextAlign.center,
                style: AppStyles.smallTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildImageContainer(
              context,
              0,
              size,
              size.width * 0.8,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildImageContainer(
                    context,
                    1,
                    size,
                    size.width * 0.39,
                  ),
                  _buildImageContainer(
                    context,
                    2,
                    size,
                    size.width * 0.39,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildImageContainer(
                    context,
                    3,
                    size,
                    size.width * 0.39,
                  ),
                  _buildImageContainer(
                    context,
                    4,
                    size,
                    size.width * 0.39,
                  ),
                ],
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
                    child: Text('Back'),
                  ),
                  AppButton(
                    onPressed: () {
                      final propertyBloc = context.read<PropertyBloc>();

                      print("=================");
                      print(propertyBloc.property.toJson());
                      print("=================");
                      Get.toNamed('createTitleScreen');
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
