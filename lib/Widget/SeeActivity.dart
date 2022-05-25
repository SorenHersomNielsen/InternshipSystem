import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';

class SeeActivity extends StatefulWidget {
  const SeeActivity({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  _SeeActivityState createState() => _SeeActivityState();
}

class _SeeActivityState extends State<SeeActivity> {

  final viewmodel = Viewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text(
          'activity'
        ));
  }
}