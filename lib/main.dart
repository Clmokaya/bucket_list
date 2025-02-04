import 'package:bucket_list/screens/add_screen.dart';
import 'package:bucket_list/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainScreen(),
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
