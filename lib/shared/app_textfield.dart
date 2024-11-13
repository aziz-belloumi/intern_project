import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final Color? borderColor;
  bool? enabled = true;
  bool obscureText = false;
  TextInputType? textInputType;
  TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  double? width;
  double? height;

  AppTextField({
    Key? key,
    this.text,
    this.icon,
    this.onChanged,
    this.textInputType,
    this.color,
    this.iconColor,
    this.borderColor,
    this.controller,
    this.validator,
    this.width,
    this.height,
    required this.obscureText,
    this.enabled,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isErrorVisible = false;
  String showErrorValidation = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: widget.height ?? size.height * 0.08, // Default height
      width: widget.width ?? size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.transparent,
        // border: Border.all(color: widget.borderColor ?? Colors.transparent),
      ),
      child: TextFormField(
        keyboardType: widget.textInputType,
        controller: widget.controller,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.color ?? Colors.transparent,
          contentPadding: EdgeInsets.symmetric(
            vertical: (widget.height ?? size.height * 0.08) * 0.3, // Adjust padding dynamically
            horizontal: size.height * 0.03,
          ),
          prefixIcon: widget.icon != null
              ? Icon(widget.icon, color: widget.iconColor)
              : null,
          hintText: widget.text ?? "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            // borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 2, color: AppColors.black.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 2, color: AppColors.black.withOpacity(0.5)),
          ),
        ),
        onChanged: widget.onChanged,
        validator: (value) {
          String? validationResult = widget.validator?.call(value);
          setState(() {
            _isErrorVisible = validationResult != null;
            showErrorValidation = validationResult.toString();
          });
          return validationResult;
        },
      ),
    );
  }
}

