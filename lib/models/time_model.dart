import 'package:flutter/material.dart';

class TimeModel with ChangeNotifier {
  int _learnTime = 10;
  int _relaxTime = 5;

  int get learnTime => _learnTime;
  int get relaxTime => _relaxTime;

  Map<String, int> get time {
    return {
      'learnTime': _learnTime,
      'relaxTime': _relaxTime,
    };
  }

  void setTime({required int learnTime, required int relaxTime}) {
    _learnTime = learnTime;
    _relaxTime = relaxTime;
    print(time);
    notifyListeners();
  }
}
