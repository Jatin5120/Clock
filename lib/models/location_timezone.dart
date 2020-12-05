import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class LocationTimeZone {
  factory LocationTimeZone() => _this ?? LocationTimeZone._();

  LocationTimeZone._() {
    initializeTimeZones();
  }
  static LocationTimeZone _this;

  Future<String> getTimeZoneName() async => FlutterNativeTimezone.getLocalTimezone();

  Future<tz.Location> getLocation([String timeZoneName]) async {
    if(timeZoneName == null || timeZoneName.isEmpty){
      timeZoneName = await getTimeZoneName();
    }
    return tz.getLocation(timeZoneName);
  }
}