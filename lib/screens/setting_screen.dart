import 'package:first_flutter_app/test_widgets/test_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/time_model.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = '/setting-screen';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double learnTime = 25;
  double relaxTime = 5;
  @override
  Widget build(BuildContext context) {
    var dataTime = Provider.of<TestTimeModel>(context, listen: false);


    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
          actions: [
            IconButton(
                onPressed: () => dataTime.setTime(
                    learnTime: learnTime.toInt(), relaxTime: relaxTime.toInt()),
                icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Lựa chọn thời gian làm việc: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Slider(
                value: learnTime,
                max: 40,
                min: 15,
                divisions: 25,
                label: '${learnTime.toInt()} min',
                onChanged: (value) {
                  // learnTime = value;
                  setState(() => learnTime = value);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Lựa chọn thời gian nghỉ ngơi: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Slider(
                value: relaxTime,
                max: 8,
                min: 4,
                divisions: 4,
                label: '${relaxTime.toInt()} min',
                onChanged: (value) {
                  setState(() => relaxTime = value);
                },
                // onChanged: (value) {
                //   setState(() => relaxTime = value);
                // },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    dataTime.setTime(
                        learnTime: learnTime.toInt(),
                        relaxTime: relaxTime.toInt());
                        Navigator.of(context).pop();
                    // print(dataTime.time);
                  },
                  child: const Text('Save'))
            ],
          ),
        ));
  }
}