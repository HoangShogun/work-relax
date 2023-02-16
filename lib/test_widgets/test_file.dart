import 'dart:async';


import 'package:first_flutter_app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTestWidget extends StatelessWidget {
  const MyTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Provider.of<TestTimeModel>(context).isRelaxTime
              ? const Text('Relax Time')
              : const Text('Work Time'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(SettingScreen.routeName),
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Consumer<TestTimeModel>(
          builder: (BuildContext context, value, _) {
            int time = value.timeRemaining;
            int initialTime =
                value.isRelaxTime ? value.relaxTime : value.learnTime;
            return Column(children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // Text of min
                        // time.toString(),
                        Duration(seconds: time).inMinutes.toString(),
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                // fontWeight: FontWeight.w300,
                                ),
                      ),
                      Text(
                        ":",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        // Text of second
                        Duration(seconds: time)
                            .inSeconds
                            .remainder(60)
                            .toString()
                            .padLeft(2, '0'),
                        style: Theme.of(context).textTheme.displayLarge,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                        color: Colors.amber,
                        strokeWidth: 20,
                        value: (initialTime - time) / initialTime,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        value.isRunning
                            ? value.stopTimer()
                            : value.startTimer(context);
                      },
                      icon: value.isRunning
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow)),
                  IconButton(
                      onPressed: () {
                        value.resetTimer();
                      },
                      icon: const Icon(Icons.restart_alt)),
                ],
              ),
            ]);
          },
        ));
  }
}

class TestTimeModel with ChangeNotifier {
  late Timer _timer;
  int _timeRemaining = 10;
  bool _isRunning = false;
  bool _isRelaxTime = false;
  int _learnTime = 10;
  int _relaxTime = 5;
  int get learnTime => _learnTime;
  int get relaxTime => _relaxTime;

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

  // startTimer(BuildContext context) {
  //   isRunning = true;
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     timeRemaining--;
  //     if (_timeRemaining <= 0) {
  //       if (isRelaxTime) {
  //         isRelaxTime = false;
  //         stopTimer();
  //         showMyDialog(context, isRelaxTime);

  //         resetTimer();
  //         startTimer(context);
  //       } else {
  //         stopTimer();
  //         showMyDialog(context, isRelaxTime);
  //         startRelaxTime(context);
  //       }
  //     }
  //   });
  // }
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
    _timer.cancel();
  }

  void resetTimer() {
    isRunning = false;
    _timer.cancel();
    _timeRemaining = learnTime;
    notifyListeners();
  }
}

Future showMyDialog(
  BuildContext context,
  bool isRelaxTime,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: isRelaxTime
            ? const Text('Quay lại làm việc thôi!!!')
            : const Text('Đến giờ giải lao rồi!!!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          )
        ],
      );
    },
  );
}
