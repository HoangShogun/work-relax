import 'package:first_flutter_app/models/count_down_model.dart';
import 'package:first_flutter_app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final coutdownData = Provider.of<CountDownModel>(context,);
    int timeRemaining = coutdownData.timeRemaining;
    bool timeRunning = coutdownData.timeRunning;
    bool relaxRunning = coutdownData.relaxRunning;
    return Scaffold(
      appBar: AppBar(
        title: Text('Work time'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingScreen.routeName),
              icon: Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Duration(seconds: timeRemaining).inMinutes.toString(),
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        // fontWeight: FontWeight.w300,
                        ),
                  ),
                  Text(
                    ":",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    Duration(seconds: timeRemaining)
                        .inSeconds
                        .remainder(60)
                        .toString()
                        .padLeft(2, '0'),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),

              // color: Colors.red,
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(
                    backgroundColor:
                        relaxRunning ? Colors.amber : Colors.green,
                    color: relaxRunning
                        ? Colors.green
                        : Colors.yellow,
                    strokeWidth: 20,
                    value: relaxRunning
                        ? (coutdownData.relaxSecTime - timeRemaining)
                                .remainder(coutdownData.relaxSecTime) /
                            (coutdownData.relaxSecTime)
                        : (coutdownData.learnSecTime - timeRemaining)
                                .remainder(coutdownData.learnSecTime) /
                            (coutdownData.learnSecTime),
                  ),
                ),
              ),
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
                  // relaxRunning
                  //     ? null
                  //     : timeRunning
                  //         ? coutdownData.stopTimer()
                  //         : coutdownData.startTimer();
                  coutdownData.start();
                },
                icon: Icon(relaxRunning
                    ? Icons.play_arrow
                    : timeRunning
                        ? Icons.pause
                        : Icons.play_arrow),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {
                  coutdownData.resetTimer();
                },
                icon: const Icon(Icons.restart_alt),
                iconSize: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
