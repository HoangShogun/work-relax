import 'dart:async';

import 'package:first_flutter_app/models/time_model.dart';
import 'package:flutter/material.dart';

class CountDownModel with ChangeNotifier {
  // final TimeModel _timeModel = TimeModel();
  // int get learnSecTime => _timeModel.learnTime;
  // int get relaxSecTime => _timeModel.relaxTime;
  int learnSecTime = 25 * 60;
  int relaxSecTime = 5 * 60;
  Timer? _timer;
  int _timeRemaining = 1000;
  bool _timeRunning = false;

  bool _relaxRunning = false;

  int get timeRemaining => _timeRemaining;
  set timeRemaining(int value) {
    _timeRemaining = value;
    notifyListeners();
  }

  bool get timeRunning=>_timeRunning;
  set timeRunning(bool value){
    _timeRunning = value;
    notifyListeners();
  }
  bool get relaxRunning=>_relaxRunning;
  set relaxRunning(bool value){
    _relaxRunning = value;
    notifyListeners();
  }

  void runTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeRemaining--;
      
      if (timeRemaining == 0) {
        stopTimer();
        if (_relaxRunning = true) {
          resetTimer();
          startTimer();
        } else {
          startRelaxTime();
        }
        
      }
    });
    // notifyListeners();
  }

  void startTimer() {
    _timeRunning = true;
    _timer?.cancel();
    runTimer();
    print('start');
    // notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _timeRunning = true;
    // notifyListeners();
    print('stop');
  }

  void resetTimer() {
    _timeRunning = false;
    _relaxRunning = false;
    _timer?.cancel();
    _timeRemaining = learnSecTime;
    // notifyListeners();
    print('reset');
  }

  void startRelaxTime() {
    _timeRunning = true;
    _relaxRunning = true;
    _timer?.cancel();

    _timeRemaining = relaxSecTime;

    runTimer();
    print('relax');
    // notifyListeners();
  }

  void start(){
    _timeRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeRemaining --;
    });
    notifyListeners();
  }
}
