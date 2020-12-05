import 'package:clock_app/utilities/custom_colors.dart';
import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {

  final Function onPressed;
  final Color buttonColor;
  final AnimationController controller;

  const PlayPauseButton({Key key, this.onPressed, this.buttonColor, this.controller}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: widget.onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        color: widget.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        child: AnimatedIcon(
          color: CustomColors.primaryTextColorDark,
          size: 30.0,
          icon: AnimatedIcons.play_pause,
          progress: widget.controller,
        ),
      ),
    );
  }
}
