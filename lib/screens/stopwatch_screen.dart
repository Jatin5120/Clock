import 'dart:async';
import 'package:clock_app/models/models.dart';
import 'package:clock_app/utilities/utilities.dart';
import 'package:clock_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StopWatchScreen extends StatefulWidget {
  final bool isDark;

  const StopWatchScreen({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  @override
  _StopWatchScreenState createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen>
    with TickerProviderStateMixin {
  AnimationController playPauseButtonController;
  AnimationController clearButtonController;
  Duration buttonDuration;
  StopWatchTime stopWatchTime;
  bool isPaused;

  @override
  void initState() {
    stopWatchTime = Provider.of<StopWatchTime>(context, listen: false);
    isPaused = false;
    buttonDuration = Duration(milliseconds: 300);
    playPauseButtonController = AnimationController(
      vsync: this,
      duration: buttonDuration,
    );
    clearButtonController =
        AnimationController(vsync: this, duration: buttonDuration);
    super.initState();
  }

  startStopWatch() {
    isPaused = false;
    stopWatchTime.setColor(CustomColors.pauseButtonColor);
    playPauseButtonController.forward();
    clearButtonController.reverse();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (this.mounted) {
        if (!isPaused) {
          stopWatchTime.updateTime();
        } else {
          timer.cancel();
        }
      }
    });
  }

  pauseStopWatch() {
    isPaused = true;
    stopWatchTime.setColor(CustomColors.startButtonColor);
    playPauseButtonController.reverse();
    clearButtonController.forward();
  }

  stopStopWatch() {
    stopWatchTime.resetTime();
    playPauseButtonController.reverse();
    clearButtonController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('stopwatch'),
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
      child: Consumer<StopWatchTime>(
        builder:
            (BuildContext context, StopWatchTime stopWatchTime, Widget child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Stop Watch',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: widget.isDark ? CustomColors.clockBGDark.withOpacity(0.5) : CustomColors.clockBGLight,
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                        color: widget.isDark ? CustomColors.dividerColorDark : CustomColors.dividerColorLight,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          stopWatchTime.getTimeToDisplay,
                          style: const TextStyle(
                            fontSize: 35.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          stopWatchTime.getMilliSecToDisplay,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PlayPauseButton(
                        onPressed: () {
                          playPauseButtonController.isCompleted
                              ? pauseStopWatch()
                              : startStopWatch();
                        },
                        buttonColor: stopWatchTime.getColor,
                        controller: playPauseButtonController,
                      ),
                      ScaleTransition(
                        scale: clearButtonController.view,
                        child: RaisedButton(
                          onPressed: () {
                            stopStopWatch();
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          color: CustomColors.stopButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10.0,
                          child: const Icon(
                            Icons.clear_rounded,
                            size: 30.0,
                            color: CustomColors.primaryTextColorDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
