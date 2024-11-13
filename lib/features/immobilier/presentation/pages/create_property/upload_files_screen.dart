import 'dart:io';

import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UploadFilesScreen extends StatefulWidget {
  UploadFilesScreen({super.key});

  @override
  State<UploadFilesScreen> createState() => _UploadFilesScreenState();
}

class _UploadFilesScreenState extends State<UploadFilesScreen> {
  String pdfFileName = "Upload PDF File";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                "Upload Files of Your Property",
                textAlign: TextAlign.center,
                style: AppStyles.smallTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            BlocListener<PropertyBloc, PropertyState>(
              listener: (context, state) {
                if (state is PdfFileUploaded) {
                  if (state is PdfFileUploaded) {
                    setState(() {
                      pdfFileName = state.pdfFilePath.split('/').last; // Extracting file name
                    });
                  }                }
              },
              child: GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );

                  if (result != null) {
                    File pdfFile = File(result.files.single.path!);
                    context
                        .read<PropertyBloc>()
                        .add(UploadPdfFile(pdfFile: pdfFile));
                  }
                  final propertyBloc = context.read<PropertyBloc>();
                  print("=================");
                  print(propertyBloc.property.toJson());
                  print("=================");
                },
                child: AppTextField(
                  enabled: false,
                  text: pdfFileName,
                  obscureText: false,
                  icon: Icons.picture_as_pdf,
                ),
              ),
            ),
            AppTextField(
              enabled: false,
              text: "Upload PDF File",
              obscureText: false,
              icon: Icons.picture_as_pdf,
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
                      child: Text('Back')),
                  AppButton(
                    onPressed: () {
                      Get.toNamed('uploadsPhotosScreen');
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
    );
  }
}
