import 'package:convergeimmob/constants/app_background.dart';
import 'package:convergeimmob/constants/app_dropdown_field.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/router.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetPriceScreen extends StatelessWidget {
  const SetPriceScreen({super.key});

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
                "Now, Set Your Price",
                textAlign: TextAlign.center,
                style: AppStyles.smallTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            AppTextField(
              obscureText: false,
              text: "Asking Price",
              onChanged: (value) {
                context.read<PropertyBloc>().add(SelectPrice(value));
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            BlocBuilder<PropertyBloc, PropertyState>(
              builder: (context, state) {
                if (state is PriceSelected) {
                  return Text("Selected Price: ${state.price}");
                }
                return SizedBox.shrink();
              },
            ),
            AppDropdownField(
                items: ["Rent", "Sale"],
                onChanged: (value) {
                  print(value);
                }),
            SizedBox(
              height: size.height * 0.02,
            ),
            AppDropdownField(
                items: ["Monthly", "weekly", "Daily"],
                onChanged: (value) {
                  print(value);
                }),
            SizedBox(
              height: size.height * 0.02,
            ),
            Spacer(
              flex: 2,
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
                  BlocBuilder<PropertyBloc, PropertyState>(
                      builder: (context, state) {
                    return AppButton(
                      onPressed: () {
                        final propertyBloc = context.read<PropertyBloc>();
                        print("=================");
                        print(propertyBloc.property.toJson());
                        print("=================");
                        context
                            .read<PropertyBloc>()
                            .add(AddProperty(propertyBloc.property));

                      },
                      width: size.width * 0.3,
                      text: 'Continue',
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
