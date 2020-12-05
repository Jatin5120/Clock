import 'dart:math';
import 'package:clock_app/models/models.dart';
import 'package:clock_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockView extends StatefulWidget {
  final double size;
  final bool isDark;

  const ClockView({Key key, this.size, this.isDark,}) : super(key: key);
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  Widget build(BuildContext context) {
    ClockTimeNow timeNow = Provider.of<ClockTimeNow>(context, listen: true);
    return Container(
      height: widget.size,
      width: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(now: timeNow.now, isDark: widget.isDark,),
        ),
      ),
    );
  }
}
