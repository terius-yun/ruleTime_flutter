import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  var _icon = Icons.play_arrow; //플레이 아이콘
  var _color = Colors.purple[400]; //플레이 색상
  Timer _timer; //타이머
  var _time = 0; //실제 시간
  var _isPlaying = false; //시작 /정지 상태값
  List<String> _saveTimes = []; //시간 기록 리스트

  @override
  //앱종료시 시간 정지
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: FloatingActionButton(
        //플레이버튼
        onPressed: () => setState(() {
          _click();
        }),
        child: Icon(_icon),
        backgroundColor: _color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _body() {
    var sec = _time ~/ 100; //초
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return Center(
      child: Column(
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(height: 70.0), //상단 여백.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  //'초'영역
                  '$sec',
                  style: TextStyle(fontSize: 80),
                ),
                Text(
                  //소수단위 '초'영역
                  '.$hundredth',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              //메인 시간 숫자와 시간기록 사이 여백
              height: 20,
            ),
            Container(
                //시간 기록
                width: 200,
                height: 300,
                child: ListView(
                  children: _saveTimes
                      .map((time) => Text(
                            time,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ))
                      .toList(),
                )),
          ]),
          Row(
            // 초기화, 시간기록
            mainAxisAlignment: MainAxisAlignment.end, // 버튼 우측으로 정렬
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // 우측에서 중앙으로 정렬
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          _reset();
                          if (!_isPlaying) {
                            _icon = Icons.play_arrow;
                            _color = Colors.purple[400];
                            _pause();
                          }
                        });
                      },
                      color: Colors.purple,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Clear Board',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          _saveTime('$sec.$hundredth');
                        });
                      },
                      color: Colors.purple,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Save Time',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ]),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
    );
  }

//시작, 일시정지 버튼
  void _click() {
    _isPlaying = !_isPlaying;

    if (_isPlaying) {
      _icon = Icons.pause;
      _color = Colors.grey[400];
      _start();
    } else {
      _icon = Icons.play_arrow;
      _color = Colors.purple[400];
      _pause();
    }
  }

//1/100초에 한 번씩 time 1씩 증가
  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

// 타이머 중지 (취소)
  void _pause() {
    _timer?.cancel();
  }

//초기화
  void _reset() {
    setState(() {
      _isPlaying = false;
      _timer?.cancel();
      _saveTimes.clear();
      _time = 0;
    });
  }

//기록하기
  void _saveTime(String time) {
    _saveTimes.insert(0, '${_saveTimes.length + 1}등 : $time');
  }
}
