import 'dart:async';
import 'dart:math';
import 'package:clock_app/models/models.dart';
import 'package:clock_app/utilities/utilities.dart';
import 'package:clock_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatefulWidget {
  final bool isDark;

  const TimerScreen({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  bool isStarted;
  Duration selectedDuration;
  AnimationController buttonController;
  Duration animationDuration = Duration(milliseconds: 500);
  TimerTime timerTime;

  @override
  void initState() {
    timerTime = Provider.of<TimerTime>(context, listen: false);
    isStarted = false;
    selectedDuration = Duration(seconds: 0);
    buttonController =
        AnimationController(vsync: this, duration: animationDuration);
    super.initState();
  }

  startMyTimer() {
    buttonController.forward();
    timerTime.setColor(CustomColors.stopButtonColor);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        if (timerTime.time > Duration(seconds: 1)) {
          timerTime.updateTime();
        } else {
          timer.cancel();
          timerTime.updateTime();
          timerTime.setColor(CustomColors.startButtonColor);
          buttonController.reverse();
          isStarted = false;
        }
      }
    });
  }

  stopMyTimer() {
    timerTime.setTime(Duration(seconds: 0));
    buttonController.reverse();
    timerTime.setColor(CustomColors.startButtonColor);
    isStarted = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height / 4;
    return Container(
      key: PageStorageKey('timer'),
      margin:  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
      child: Consumer<TimerTime>(
        builder: (BuildContext context, TimerTime timerTime, Widget child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: const Text(
                  'Timer',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return SweepGradient(
                          startAngle: 0.0,
                          endAngle: 2 * pi,
                          transform: const GradientRotation(-pi / 2),
                          center: Alignment.center,
                          stops: [
                            (timerTime.time.inSeconds /
                                    selectedDuration.inSeconds)
                                .clamp(0.0, 1.0),
                            (timerTime.time.inSeconds /
                                selectedDuration.inSeconds)
                                .clamp(0.0, 1.0)
                          ],
                          colors: [
                            widget.isDark ? CustomColors.activeColorDark : CustomColors.activeColorLight,
                            widget.isDark ? CustomColors.inactiveIconColorDark : CustomColors.inactiveIconColorLight,
                          ],
                        ).createShader(rect);
                      },
                      child: Center(
                        child: Container(
                          width: size,
                          height: size,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/radial_scale.png'),
                              ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size - 40,
                        height: size - 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.isDark ? CustomColors.pageBackgroundColorDark : CustomColors.pageBackgroundColorLight,
                        ),
                        child: MaterialButton(
                          shape: const CircleBorder(),
                          color: widget.isDark ? CustomColors.clockBGDark.withOpacity(0.5) : CustomColors.clockBGLight,
                          padding: const EdgeInsets.all(15.0),
                          onPressed: () async {
                            selectedDuration = await showDurationPicker(
                              context: context,
                              initialTime: timerTime.time,
                            ) ?? timerTime.time;
                            timerTime
                                .setTime(selectedDuration ?? timerTime.time);
                          },
                          child: Text(
                            timerTime.timeToDisplay,
                            style: const TextStyle(
                              fontSize: 35.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: PlayPauseButton(
                  onPressed: () {
                    buttonController.isCompleted
                        ? stopMyTimer()
                        : startMyTimer();
                  },
                  buttonColor: timerTime.buttonColor,
                  controller: buttonController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
