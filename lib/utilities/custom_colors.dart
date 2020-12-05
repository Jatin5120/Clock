import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryTextColorLight = Color(0xFF313131);
  static const Color primaryTextColorDark = Color(0xFFFFFFFF);

  static const Color coverColorLight = Color(0x22000000);
  static const Color coverColorDark = Color(0x22FFFFFF);

  static const Color shadowColorLight = Color(0x55FFFFFF);
  static const Color shadowColorDark = Color(0x22444444);

  static const Color activeIconColorLight = Color(0xFF0F8185);
  static const Color activeIconColorDark = Color(0xFFFCF4F9);
  static const Color inactiveIconColorLight = Color(0xFF78BFC2);
  static const Color inactiveIconColorDark = Color(0xAA7C7C84);

  static const Color activeColorLight = Color(0xFF46999C);
  static const Color activeColorDark = Color(0xFF64FFDA);

  static const Color dividerColorLight = Color(0xFF46999C);
  static const Color dividerColorDark = Color(0xFF7D7986);

  static const Color pageBackgroundColorLight = Color(0xFFA8DADC);
  static const Color pageBackgroundColorDark = Color(0xFF2D2F41);
  static const Color menuBackgroundColorLight = Color(0xFFB3E4E6);
  static const Color menuBackgroundColorDark = Color(0xFF242634);

  static const Color clockBGLight = Color(0xFF75CED1);
  static const Color clockBGDark = Color(0xFF444974);
  static const Color clockOutlineLight = Color(0xFF46999C);
  static const Color clockOutlineDark = Color(0xFFDDDDFF);

  static const Color secHandColorLight = Color(0xFFFB8500);
  static const Color secHandColorDark = Color(0xFFFFB74D);

  static const Color minHandStartColorLight = Color(0xFFEA74AB);
  static const Color minHandStartColorDark = Color(0xFF748EF6);
  static const Color minHandEndColorLight = Color(0xFFC279FB);
  static const Color minHandEndColorDark = Color(0xFF77DDFF);

  static const Color hourHandStartColorLight = Color(0xFF7282C2);
  static const Color hourHandStartColorDark = Color(0xFFC279FB);
  static const Color hourHandEndColorLight = Color(0xFF471EA6);
  static const Color hourHandEndColorDark = Color(0xFFEA74AB);

  static const Color startButtonColor = Color(0xFF009E60);
  static const Color stopButtonColor = Color(0xFFE63946);
  static const Color pauseButtonColor = Color(0xFFE09A12);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static const List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static const List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static const List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static const List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static const List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}