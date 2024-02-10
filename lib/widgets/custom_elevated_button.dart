import 'package:flutter/material.dart';
import 'package:personal_area/theme/palette.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.height,
      this.borderRadius,
      this.textWeight,
      this.splashColor,
      this.width,
      this.loading = false,
      this.progressColor,
      this.disabled});

  final String buttonText;
  final Function() onPressed;
  Color? backgroundColor;
  Color? textColor;
  double? height;
  double? width;
  double? borderRadius;
  FontWeight? textWeight;
  Color? splashColor;
  bool loading;
  Color? progressColor;
  bool? disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled != null && disabled! ? null : onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: splashColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 7)),
            backgroundColor: backgroundColor ?? Palette.primaryColor),
        child: loading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: progressColor ?? Colors.white,
                ))
            : Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor ?? Colors.white, fontWeight: textWeight),
              ),
      ),
    );
  }
}
