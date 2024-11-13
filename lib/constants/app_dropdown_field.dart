import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppDropdownField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final Color? iconColor;
  final List<dynamic> items;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final dynamic startValue;
  final double? height;
  final double? width;

  const AppDropdownField({
    Key? key,
    this.hintText,
    this.icon,
    this.iconColor,
    required this.items,
    this.onChanged,
    this.validator,
    this.startValue,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _AppDropdownFieldState createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  dynamic selectedItem;

  @override
  void didUpdateWidget(AppDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items && widget.items.isNotEmpty) {
      setState(() {
        if (!widget.items.contains(selectedItem)) {
          selectedItem = widget.items.first;
          // Notify the parent widget about the change
          widget.onChanged?.call(selectedItem);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: widget.height ?? size.height * 0.08,
      width: widget.width ?? size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.transparent,
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<dynamic>(
              value:
                  widget.startValue != null ? widget.startValue : selectedItem,
              icon: widget.icon != null
                  ? Icon(widget.icon, color: widget.iconColor)
                  : null,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              style: AppStyles.title(),
              dropdownColor: Colors.white,
              items:
                  widget.items.map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child:
                      // value is CarType
                      //     ? Row(
                      //   children: [
                      //     Text(value.type ?? '',
                      //         style: AppStyles.hintTextAuth),
                      //     SizedBox(width: size.width * 0.02),
                      //     Text(value.name ?? '',
                      //         style: AppStyles.hintTextAuth),
                      //   ],
                      // )
                      //     :
                      Text(value.toString(), style: AppStyles.title()),
                );
              }).toList(),
              hint: Text(widget.hintText ?? "", style: AppStyles.title()),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
                widget.onChanged?.call(value);
              },
              validator: widget.validator,
            ),
          ],
        ),
      ),
    );
  }
}
