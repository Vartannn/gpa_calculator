import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const GPAApp());
}

class GPAApp extends StatelessWidget {
  const GPAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GPAHomePage(),
    );
  }
}


