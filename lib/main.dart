import 'package:flutter/material.dart';
import 'package:internship/Widget/Signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body:Padding(padding: const EdgeInsets.all(20), child: SignIn())),
    );
  }
}

