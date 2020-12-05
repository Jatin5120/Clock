import 'dart:async';
import 'package:clock_app/models/models.dart';
import 'package:clock_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockScreen extends StatefulWidget {
  final bool isDark;

  const ClockScreen({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  void initState() {
    ClockTimeNow timeNow = ClockTimeNow();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        timeNow = Provider.of<ClockTimeNow>(context, listen: false);
        timeNow.updateTime();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('clock'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
      child: Consumer<ClockTimeNow>(
        builder: (BuildContext context, ClockTimeNow timeNow, Widget child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: const Text(
                  'Clock',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeNow.getTime,
                      style: const TextStyle(
                        fontSize: 64.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      timeNow.getDate,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.center,
                  child: ClockView(
                    size: MediaQuery.of(context).size.height / 4,
                    isDark: widget.isDark,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Timezone',
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.language,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          'UTC ' +
                              timeNow.getOffsetSign +
                              timeNow.getTimeZoneOffset,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
