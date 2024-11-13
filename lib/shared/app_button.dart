import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.width,
    this.height,
    this.color,
    this.bgColor,
    this.text,
    this.onPressed,
  });

  final double? width;
  final double? height;
  final Color? color;
  final Color? bgColor;
  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width * 0.6,
      height: height ?? size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            bgColor ?? AppColors.bluePrimaryHigher,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          text ?? '',
          style: AppStyles.smallTitle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: color ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
