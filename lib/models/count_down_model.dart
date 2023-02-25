import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import '../widgets/my_dialog.dart';

class CountDownModel with ChangeNotifier {
  Timer? _timer;
  int _timeRemaining = 10;
  bool _isRunning = false;
  bool _isRelaxTime = false;
  int _learnTime = 10;
  int _relaxTime = 5;
  int get learnTime => _learnTime;
  int get relaxTime => _relaxTime;
  final _audioPlayer = AudioPlayer();
  Future<void> playSound() async {
    for (int i = 0; i < 2; i++) {
      await _audioPlayer.play(AssetSource('sounds/ga_gay.mp3'));
      //need to play two times
    }
  }

  void setTime({required int learnTime, required int relaxTime}) {
    _learnTime = learnTime;
    _relaxTime = relaxTime;
    resetTimer();
    // print(time);
    notifyListeners();
  }

  int get timeRemaining => _timeRemaining;

  bool get isRunning => _isRunning;

  bool get isRelaxTime => _isRelaxTime;

  set timeRemaining(int value) {
    _timeRemaining = value;
    notifyListeners();
  }

  set isRunning(bool value) {
    _isRunning = value;
    notifyListeners();
  }

  set isRelaxTime(bool value) {
    _isRelaxTime = value;
    notifyListeners();
  }

  void startTimer(BuildContext context) {
    isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeRemaining--;
      if (_timeRemaining <= 0) {
        if (isRelaxTime) {
          stopTimer();
          Future.delayed(
                  Duration.zero, () => showMyDialog(context, isRelaxTime))
              .then((value) {
            resetTimer();
            startTimer(context);
            isRelaxTime = false;
          });
        } else {
          stopTimer();
          Future.delayed(
                  Duration.zero, () => showMyDialog(context, isRelaxTime))
              .then((value) {
            startRelaxTime(context);
          });
        }
        playSound();
      }
    });
  }

  void startRelaxTime(BuildContext context) {
    isRelaxTime = true;
    timeRemaining = relaxTime;
    startTimer(context);
  }

  void stopTimer() {
    isRunning = false;
    _timer?.cancel();
  }

  void resetTimer() {
    isRunning = false;
    if (_timer == null) {
      _timeRemaining = learnTime;
      notifyListeners();
      return;
    }
    _timer?.cancel();

    _timeRemaining = learnTime;
    notifyListeners();
  }
}
