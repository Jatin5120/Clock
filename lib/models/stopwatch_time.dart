import 'dart:ui';
import 'package:clock_app/utilities/custom_colors.dart';
import 'package:flutter/foundation.dart';

class StopWatchTime extends ChangeNotifier {

  Duration time = Duration();
  String timeToDisplay = Duration().toString().split('.').first;
  String milliSecToDisplay = Duration().toString().split('.').last.substring(0, 2);
  Color buttonColor = CustomColors.startButtonColor;

  setColor(Color color){
    buttonColor = color;
    notifyListeners();
  }

  Color get getColor => buttonColor;

  String get getTimeToDisplay => timeToDisplay;

  String get getMilliSecToDisplay => milliSecToDisplay;

  updateTime() {
    time += Duration(milliseconds: 10);
    timeToDisplay = time.toString().split('.').first;
    milliSecToDisplay = time.toString().split('.').last.substring(0, 2);
    notifyListeners();
  }

  resetTime() {
    time = Duration(milliseconds: 0);
    timeToDisplay = time.toString().split('.').first;
    milliSecToDisplay = time.toString().split('.').last.substring(0, 2);
    notifyListeners();
  }

}