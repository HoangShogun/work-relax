import 'package:first_flutter_app/models/count_down_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'setting_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Provider.of<CountDownModel>(context).isRelaxTime
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
        body: Consumer<CountDownModel>(
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