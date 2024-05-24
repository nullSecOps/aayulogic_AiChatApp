import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/constant.dart';
import 'package:gemini/pages/homescreen.dart';

void main() {
  Gemini.init(apiKey: API_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gemini AI ",
      theme: ThemeData(useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
