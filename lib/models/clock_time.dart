import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ClockTimeNow extends ChangeNotifier {
  DateTime now = DateTime.now();
  String time = DateFormat('HH:mm').format(DateTime.now());
  String date = DateFormat('EEE, d MMM').format(DateTime.now());
  String timeZoneOffset = DateTime.now().timeZoneOffset.toString().split('.').first;
  String offsetSign = '';

  get getNow => now;

  get getTime => time;

  get getDate => date;

  get getTimeZoneOffset => timeZoneOffset;

  get getOffsetSign => offsetSign;

  updateTime() {
    now = DateTime.now();
    time = DateFormat('HH:mm').format(now);
    date = DateFormat('EEE, d MMM').format(now);
    timeZoneOffset = now.timeZoneOffset.toString().split('.').first;
    offsetSign = '';

    if (!timeZoneOffset.startsWith('-')) offsetSign = '+';
    notifyListeners();
  }
}
