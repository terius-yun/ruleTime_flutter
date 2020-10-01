import 'dart:ui';
import 'package:alarmflutterapp/timer.dart';
import 'package:alarmflutterapp/home.dart';
import 'package:alarmflutterapp/stop_watch.dart';
import 'package:flutter/material.Dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [TimerEx(), Home(), StopWatch()];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.av_timer),
                title: Text('Timer'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                title: Text('Home'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                title: Text('StopWatch'),
              )
            ]));
  }
}
