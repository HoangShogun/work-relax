import 'package:first_flutter_app/models/count_down_model.dart';
import 'package:first_flutter_app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountDownModel>(
          create: (context) => CountDownModel(),
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
        home: const HomePage(),
      ),
    );
  }
}
