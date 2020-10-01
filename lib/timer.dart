import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:numberpicker/numberpicker.dart';

class TimerEx extends StatefulWidget {
  @override
  _TimerExState createState() => _TimerExState();
}

class _TimerExState extends State<TimerEx> {
  Timer _timer;
  int _sec = 0;
  int _min = 0;
  int _hour = 0;
  int timeForTimer = 0;
  String timeToDisplay = "";

  void startTimer() {
    timeForTimer = ((_hour * 60 * 60) + (_min * 60) + _sec);
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (timeForTimer < 1) {
            timer.cancel();
          } else if (timeForTimer < 60) {
            timeToDisplay = timeForTimer.toString();
            timeForTimer = timeForTimer - 1;
          } else if (timeForTimer < 3600) {}
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new NumberPicker.integer(
                  initialValue: _hour,
                  minValue: 0,
                  maxValue: 24,
                  onChanged: (value) => setState(() => _hour = value),
                ),
                new NumberPicker.integer(
                  initialValue: _min,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (value) => setState(() => _min = value),
                ),
                new NumberPicker.integer(
                  initialValue: _sec,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (value) => setState(() => _sec = value),
                ),
              ],
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                startTimer();
              },
              child: Text("start"),
              color: Colors.purple,
              textColor: Colors.white,
            ),
          ),
          Text(
            "$timeToDisplay",
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }
}
