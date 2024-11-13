import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDescriptionScreen extends StatelessWidget {
  const CreateDescriptionScreen({super.key});

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
                "Write Your Property Description ",
                textAlign: TextAlign.center,
                style: AppStyles.smallTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            AppTextField(
              obscureText: false,
              height: size.height * 0.5,
              onChanged: (value) {
                context.read<PropertyBloc>().add(SelectDescription(value));
              },
            ),
            Spacer(),
            BlocBuilder<PropertyBloc, PropertyState>(
              builder: (context, state) {
                if (state is DescriptionSelected) {
                  return Text("Selected Description: ${state.description}");
                }
                return SizedBox.shrink();
              },
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
                      Get.toNamed('setPriceScreen');
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
