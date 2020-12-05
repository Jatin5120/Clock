import 'dart:math';
import 'package:clock_app/utilities/utilities.dart';
import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  DateTime now;
  bool isDark;

  ClockPainter({
    this.now,
    this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);

    Paint outerBorder = Paint()
      ..color = isDark ? CustomColors.clockOutlineDark : CustomColors.clockOutlineLight
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 25
      ..style = PaintingStyle.stroke;
    Paint circleFill = Paint()
      ..color = CustomColors.clockBGDark
      ..shader = RadialGradient(
        colors: isDark ? [
          CustomColors.clockBGDark,
          CustomColors.clockBGDark.withOpacity(0.5),
          CustomColors.shadowColorDark,
        ] : [
          CustomColors.clockBGLight,
          CustomColors.clockBGLight.withOpacity(0.5),
          CustomColors.shadowColorLight,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    Paint hourHand = Paint()
      ..shader = RadialGradient(colors: isDark ? [
        CustomColors.hourHandStartColorDark,
        CustomColors.hourHandEndColorDark,
      ] : [
        CustomColors.hourHandStartColorLight,
        CustomColors.hourHandEndColorLight,
      ],).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;
    Paint minuteHand = Paint()
      ..shader = RadialGradient(colors: isDark ? [
        CustomColors.minHandStartColorDark,
        CustomColors.minHandEndColorDark,
      ] : [
        CustomColors.minHandStartColorLight,
        CustomColors.minHandEndColorLight,
      ],).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30
      ..style = PaintingStyle.stroke;
    Paint secondHand = Paint()
      ..color = isDark? CustomColors.secHandColorDark : CustomColors.secHandColorLight
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60
      ..style = PaintingStyle.stroke;
    Paint outerPattern = Paint()
      ..color = isDark ? CustomColors.clockOutlineDark : CustomColors.clockOutlineLight
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    Paint innerCircle = Paint()
      ..color = isDark ? CustomColors.clockOutlineDark : CustomColors.clockOutlineLight
      ..style = PaintingStyle.fill;

    double outerRadius = radius;
    double innerRadius = radius * 0.9;
    for (int i = 0; i < 360; i += 15) {
      double startX = centerX + innerRadius * cos(i * pi / 180);
      double startY = centerY + innerRadius * sin(i * pi / 180);

      double endX = centerX + outerRadius * cos(i * pi / 180);
      double endY = centerY + outerRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), outerPattern);
    }

    double hourX = centerX +
        radius * 0.4 * cos((now.hour * 30 + now.minute * 0.5) * pi / 180);
    double hourY = centerY +
        radius * 0.4 * sin((now.hour * 30 + now.minute * 0.5) * pi / 180);
    Offset hourPoint = Offset(hourX, hourY);

    double minuteX = centerX + radius * 0.55 * cos(now.minute * 6 * pi / 180);
    double minuteY = centerY + radius * 0.55 * sin(now.minute * 6 * pi / 180);
    Offset minutePoint = Offset(minuteX, minuteY);

    double secondX = centerX + radius * 0.65 * cos(now.second * 6 * pi / 180);
    double secondY = centerY + radius * 0.65 * sin(now.second * 6 * pi / 180);
    Offset secondPoint = Offset(secondX, secondY);

    canvas.drawCircle(center, radius * 0.75, circleFill);
    canvas.drawCircle(center, radius * 0.75, outerBorder);

    canvas.drawLine(center, hourPoint, hourHand);
    canvas.drawLine(center, minutePoint, minuteHand);
    canvas.drawLine(center, secondPoint, secondHand);

    canvas.drawCircle(center, radius / 15, innerCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
