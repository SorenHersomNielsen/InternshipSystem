import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';

class SeeActivity extends StatefulWidget {
  const SeeActivity({Key? key, required this.userId, required this.ActivityId, required this.date, required this.headline})
      : super(key: key);

  final int userId;
  final int ActivityId;
  final String headline;
  final String date;

  @override
  _SeeActivityState createState() => _SeeActivityState();
}

class _SeeActivityState extends State<SeeActivity> {

  final viewmodel = Viewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
          child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                           Text(
                            widget.headline,
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.date,
                            style: const TextStyle(

                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Tilmeld',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Frameld',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                ),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Ved ikke',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                ),
                              ),
                            ],
                          )

                        ],
                      )
                    ],
                  ),
          )
        );
  }
}