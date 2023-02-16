import 'package:first_flutter_app/models/count_down_model.dart';
import 'package:first_flutter_app/models/time_model.dart';
import 'package:first_flutter_app/screens/setting_screen.dart';
import 'package:first_flutter_app/test_widgets/test_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimeModel>(
          create: (context) => TimeModel(),
        ),
        ChangeNotifierProvider<CountDownModel>(
          create: (context) => CountDownModel(),
        ),
        ChangeNotifierProvider<TestTimeModel>(
          create: (context) => TestTimeModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Countdown App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          SettingScreen.routeName: (context) => SettingScreen(),
        },
        // home: HomePage(),
        home: MyTestWidget(),
      ),
    );
  }
}
