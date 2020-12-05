import 'package:clock_app/utilities/custom_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimerTime extends ChangeNotifier {

  Duration time = Duration(seconds: 0);
  Color buttonColor = CustomColors.startButtonColor;
  String timeToDisplay = Duration().toString().split('.').first;

  setColor(Color color) {
    buttonColor = color;
    notifyListeners();
  }

  Duration get getTime => time;

  setTime(Duration timerTime) {
      time = timerTime;
      timeToDisplay = time.toString().split('.').first;
      notifyListeners();
  }

  updateTime() {
    if (time > Duration(seconds: 0)) {
      time -= Duration(seconds: 1);
      timeToDisplay = time.toString().split('.').first;
      notifyListeners();
    }
  }

}