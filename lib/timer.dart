import 'package:alarmflutterapp/home.dart';
import 'package:alarmflutterapp/main.dart';
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
  bool started = true;
  bool stopped = true;
  bool checktimer = true;
  String timeToDisplay = "";

  void startTimer() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((_hour * 60 * 60) + (_min * 60) + _sec);
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (timeForTimer < 1 || checktimer == false) {
            timer.cancel();
            if (timeForTimer == 0) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            }
          } else if (timeForTimer < 60) {
            timeToDisplay = timeForTimer.toString();
            timeForTimer = timeForTimer - 1;
          } else if (timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            timeToDisplay = m.toString() + ":" + s.toString();
            timeForTimer = timeForTimer - 1;
          } else {
            int h = timeForTimer ~/ 3600;
            int t = timeForTimer - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":" + s.toString();
            timeForTimer = timeForTimer - 1;
          }
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
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    new NumberPicker.integer(
                      initialValue: _hour,
                      minValue: 0,
                      maxValue: 24,
                      onChanged: (value) => setState(() => _hour = value),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    new NumberPicker.integer(
                      initialValue: _min,
                      minValue: 0,
                      maxValue: 60,
                      onChanged: (value) => setState(() => _min = value),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    new NumberPicker.integer(
                      initialValue: _sec,
                      minValue: 0,
                      maxValue: 60,
                      onChanged: (value) => setState(() => _sec = value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$timeToDisplay",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  onPressed: () {
                    startTimer();
                  },
                  child: Text(
                    "start",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.purple,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  onPressed: () {
                    startTimer();
                  },
                  child: Text(
                    "stop",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.purple,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
