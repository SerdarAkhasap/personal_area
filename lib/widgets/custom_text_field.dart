import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_area/theme/palette.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.enabled,
      this.height,
      this.maxLength,
      this.keyboardType,
      this.style,
      this.inputFormatters});

  String? hintText;
  TextEditingController? controller;
  bool? enabled;
  double? height;
  int? maxLength;
  TextInputType? keyboardType;
  TextStyle? style;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 45,
      child: TextField(
        onTap: () => {},
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        enabled: enabled,
        controller: controller,
        expands: true,
        maxLines: null,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.next,
        style: style ?? const TextStyle(
          fontSize: 13,
        ),
        cursorColor: Palette.primaryColor,
        cursorWidth: 2,
        decoration: InputDecoration(
          counterText: '',
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          floatingLabelStyle:
              const TextStyle(color: Palette.primaryColor, fontSize: 16),
          isDense: true,
          isCollapsed: false,
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide:
                  const BorderSide(width: 2, color: Palette.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                width: 2,
              )),
        ),
      ),
    );
  }
}
