import 'package:flutter/material.dart';
import 'package:mobile_dev_saham_rakyat/pages/home/home.ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Dev Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeUI(),
    );
  }
}
