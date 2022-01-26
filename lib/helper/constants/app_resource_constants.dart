import 'package:flutter/material.dart';

class ResourceConstants {
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Color appBG = Color.fromARGB(255, 255, 255, 255);
  static Color ButtonBG = Color.fromARGB(255, 9, 58, 62);
  static Color textFormFieldColor = Colors.white;
  static Color textformFieldIconColor = Colors.grey;
  static Color textformFieldFocusBorderColor = Colors.black;
  static Color textformFieldDisableBorderColor = Colors.black;
  static Color textformFieldEnabledBorderColor = Colors.black;
  static Color textformFieldFocusedErrorBorderColor = Colors.black;
  static Color textformFieldErrorBorderColor = Colors.red;
  static TextStyle inputHintTextStyle = TextStyle(
      fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w500);

  static Color homeScreenTodayWidgetColor = Color(0xff00A1FF).withOpacity(0.5);
  static Color homeScreenAppBarColor = Color.fromARGB(255, 255, 255, 255);

  static InputDecoration textFieldDecoration(IconData icons, String hintText) =>
      InputDecoration(
          fillColor: ResourceConstants.textFormFieldColor,
          filled: true,
          prefixIcon:
              Icon(icons, color: ResourceConstants.textformFieldIconColor),
          errorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
                color: ResourceConstants.textformFieldErrorBorderColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ResourceConstants.textformFieldFocusedErrorBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ResourceConstants.textformFieldFocusBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ResourceConstants.textformFieldDisableBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ResourceConstants.textformFieldEnabledBorderColor),
          ),
          hintText: hintText);

  static TextStyle appbarTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );
}
