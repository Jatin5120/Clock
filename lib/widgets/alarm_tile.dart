import 'package:clock_app/models/models.dart';
import 'package:clock_app/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmTile extends StatefulWidget {
  final AlarmInfo alarm;
  final Function delete;

  const AlarmTile({Key key, this.alarm, this.delete}) : super(key: key);

  @override
  _AlarmTileState createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: boxDecoration(GradientTemplate
          .gradientTemplate[widget.alarm.gradientColorIndex].colors),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.label,
                    color: CustomColors.primaryTextColorDark,
                    size: 24,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.alarm.title,
                    style: TextStyle(
                      color: CustomColors.primaryTextColorDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  )
                ],
              ),
              Switch(
                value: widget.alarm.isPending ?? true,
                onChanged: (bool value) {
                  this.setState(() {
                    widget.alarm.isPending = value;
                  });
                },
                activeColor: CustomColors.primaryTextColorDark,
              )
            ],
          ),
          Row(
            children: [
              Text(
                'Mon - Fri',
                style: TextStyle(
                  color: CustomColors.primaryTextColorDark,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 15.0,
                color: CustomColors.primaryTextColorDark,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('HH:mm a').format(widget.alarm.alarmDateTime),
                style: TextStyle(
                  color: CustomColors.primaryTextColorDark,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_rounded,
                  color: CustomColors.primaryTextColorDark,
                ),
                splashColor: CustomColors.dividerColorDark,
                onPressed: widget.delete,
              )
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration(List<Color> gradient) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.centerLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withOpacity(0.4),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: Offset(4, 4),
          ),
        ]);
  }
}
