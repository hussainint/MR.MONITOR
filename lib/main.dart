import 'package:MONITOR/HomeScreen.dart';
import 'package:MONITOR/download.dart';
import 'package:flutter/material.dart';
import './login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        Download.routeName: (ctx) => Download(),
      },
    );
  }
}
