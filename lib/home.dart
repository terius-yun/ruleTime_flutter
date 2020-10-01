import 'package:flutter/material.dart';
import 'Dart:async';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _timeString;

  @override
  void initState() {
    String _timeString =
        "${new DateFormat.H().format(new DateTime.now())} : ${DateTime.now().minute} :${DateTime.now().second}";
    new DateFormat.Hms().format(new DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Current Time",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              _timeString,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }

  void _getCurrentTime() {
    setState(() {
      _timeString =
          "${new DateFormat.H().format(new DateTime.now())} : ${DateTime.now().minute} : ${DateTime.now().second}";
      if (DateTime.now().minute < 10) {
        _timeString =
            "${new DateFormat.H().format(new DateTime.now())} : 0${DateTime.now().minute} : ${DateTime.now().second}";
      }
      if (DateTime.now().second < 10)
        _timeString =
            "${new DateFormat.H().format(new DateTime.now())} : ${DateTime.now().minute} : 0${DateTime.now().second}";
    });
  }
}
