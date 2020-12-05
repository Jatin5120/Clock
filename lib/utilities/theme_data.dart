import 'package:clock_app/utilities/utilities.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: CustomColors.pageBackgroundColorLight,
  backgroundColor: CustomColors.pageBackgroundColorLight,
  accentColor: CustomColors.activeColorLight,
  canvasColor: CustomColors.pageBackgroundColorLight,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColors.pageBackgroundColorLight,
    foregroundColor: CustomColors.primaryTextColorLight,
  ),
  timePickerTheme: TimePickerThemeData(
      backgroundColor: CustomColors.pageBackgroundColorLight,
      hourMinuteColor: CustomColors.menuBackgroundColorLight,
      hourMinuteTextColor: CustomColors.primaryTextColorLight,
      entryModeIconColor: CustomColors.primaryTextColorLight,
      dialBackgroundColor: CustomColors.menuBackgroundColorLight,
      dialTextColor: CustomColors.primaryTextColorLight,
      dayPeriodTextColor: CustomColors.primaryTextColorLight,
      dayPeriodColor: CustomColors.menuBackgroundColorLight,
      helpTextStyle: TextStyle(
        fontSize: 10.0,
        color: CustomColors.primaryTextColorLight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      )
  ),
  dialogBackgroundColor: CustomColors.pageBackgroundColorLight,
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: CustomColors.pageBackgroundColorDark,
  backgroundColor: CustomColors.pageBackgroundColorDark,
  accentColor: CustomColors.activeColorDark,
  canvasColor: CustomColors.pageBackgroundColorDark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColors.pageBackgroundColorDark,
    foregroundColor: CustomColors.primaryTextColorDark,
  ),
  timePickerTheme: TimePickerThemeData(
      backgroundColor: CustomColors.menuBackgroundColorDark,
      hourMinuteColor: CustomColors.pageBackgroundColorDark,
      hourMinuteTextColor: CustomColors.primaryTextColorDark,
      entryModeIconColor: CustomColors.primaryTextColorDark,
      dialBackgroundColor: CustomColors.pageBackgroundColorDark,
      dialTextColor: CustomColors.primaryTextColorDark,
      dayPeriodTextColor: CustomColors.primaryTextColorDark,
      dayPeriodColor: CustomColors.pageBackgroundColorDark,
      helpTextStyle: TextStyle(
        fontSize: 10.0,
        color: CustomColors.primaryTextColorDark,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      )
  ),
  dialogBackgroundColor: CustomColors.pageBackgroundColorDark,
);