import 'package:clock_app/main.dart';
import 'package:clock_app/models/models.dart';
import 'package:clock_app/data/data.dart';
import 'package:clock_app/utilities/utilities.dart';
import 'package:clock_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmScreen extends StatefulWidget {
  final bool isDark;

  const AlarmScreen({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with SingleTickerProviderStateMixin {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  String alarmHeading = 'Alarm';
  AnimationController spinKitController;
  Duration animationDuration;

  @override
  void initState() {
    animationDuration = Duration(milliseconds: 500);
    spinKitController =
        AnimationController(vsync: this, duration: animationDuration);
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print("------------- DataBase Initialized --------------");
      loadAlarms();
    });
    super.initState();
  }

  loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('alarm'),
      margin: const EdgeInsets.fromLTRB(10.0, 64.0, 10.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Alarm',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data.map<Widget>((alarm) {
                        return AlarmTile(
                          alarm: alarm,
                          delete: () {
                            _alarmHelper.deleteAlarm(alarm.id);
                            alarms.remove(alarm);
                            loadAlarms();
                          },
                        );
                      }).followedBy([
                        if (alarms.length < 5)
                          _buildAddAlarm(context)
                        else
                          Center(
                            child: const Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
                              child: Text(
                                'Only 5 Alarms Allowed',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  letterSpacing: 1.0,
                                  wordSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                      ]).toList(),
                    );
                  return Center(
                    child: SpinKitWave(
                      color: widget.isDark
                          ? CustomColors.activeColorDark
                          : CustomColors.activeColorLight,
                      duration: animationDuration,
                      controller: spinKitController,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAlarm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: widget.isDark
            ? CustomColors.coverColorDark
            : CustomColors.coverColorLight,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: widget.isDark
              ? CustomColors.dividerColorDark
              : CustomColors.dividerColorLight,
          width: 2,
        ),
      ),
      child: FlatButton(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 25.0),
        onPressed: () {
          _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
          _buildBottomSheet(context);
        },
        child: Column(
          children: const [
            Icon(
              Icons.add_alarm,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Add Alarm',
            ),
          ],
        ),
      ),
    );
  }

  void _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: widget.isDark
          ? CustomColors.pageBackgroundColorDark
          : CustomColors.pageBackgroundColorLight,
      useRootNavigator: true,
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FlatButton(
                        shape: StadiumBorder(
                          side: BorderSide(
                            width: 1,
                            color: widget.isDark
                                ? CustomColors.primaryTextColorDark
                                : CustomColors.primaryTextColorLight,
                          ),
                        ),
                        color: widget.isDark
                            ? CustomColors.menuBackgroundColorDark
                            : CustomColors.menuBackgroundColorLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          _alarmTimeString,
                          style: const TextStyle(
                            fontSize: 32.0,
                          ),
                        ),
                        onPressed: () => _setAlarmTime(setModalState),
                      ),
                      buildListTile('Title', Icons.title, () {}),
                      buildListTile('Repeat', Icons.repeat, () {}),
                      buildListTile('Sound', Icons.audiotrack, () {}),
                    ],
                  ),
                  FloatingActionButton.extended(
                    label: Text('Save'),
                    icon: Icon(Icons.alarm),
                    onPressed: () async {
                      DateTime scheduleAlarmDateTime;
                      if (_alarmTime.isAfter(DateTime.now()))
                        scheduleAlarmDateTime = _alarmTime;
                      else
                        scheduleAlarmDateTime =
                            _alarmTime.add(Duration(days: 1));

                      AlarmInfo alarmInfo = AlarmInfo(
                        alarmDateTime: scheduleAlarmDateTime,
                        gradientColorIndex: alarms.length,
                        title: 'Alarm',
                      );

                      _alarmHelper.insertAlarm(alarmInfo);
                      alarms.add(alarmInfo);
                      loadAlarms();
                      _scheduleAlarm(scheduleAlarmDateTime);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildListTile(String text, IconData icon, Function onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(
            '$text',
            style: const TextStyle(),
          ),
          leading: Icon(
            icon,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }

  void _setAlarmTime(void Function(void Function()) setModalState) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      DateTime now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      _alarmTime = selectedDateTime;
      setModalState(() {
        _alarmTimeString = '${selectedTime.hour}:${selectedTime.minute}';
      });
    }
  }

  void _scheduleAlarm(DateTime dateTime) async {
    if (!(await Permission.location.isGranted)) {
      await Permission.location.request();
    }
    if (await Permission.location.isGranted) {
      {
        final locationTimeZone = LocationTimeZone();
        String timeZoneName = await locationTimeZone.getTimeZoneName();
        tz.Location location = await locationTimeZone.getLocation(timeZoneName);
        tz.TZDateTime scheduledNotificationDateTime =
            tz.TZDateTime.from(dateTime, location);

        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          'alarm_0',
          'alarm_notification',
          'Channel for Alarm Notification',
          icon: 'ninja',
          sound: RawResourceAndroidNotificationSound('a_long_cold_string'),
          largeIcon: DrawableResourceAndroidBitmap('ninja'),
        );

        IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
          sound: 'a_long_cold_string.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

        NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: iosNotificationDetails,
        );

        await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Office',
          'Good morning! Time to go to Office',
          scheduledNotificationDateTime,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
        );
      }
    }
  }
}
