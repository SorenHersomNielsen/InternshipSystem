import 'package:flutter/material.dart';
import 'package:internship/Model/Activty.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:intl/intl.dart';

class Activtes extends StatefulWidget {
  Activtes({Key? key, required this.Role, required this.Id}) : super(key: key);

  String Role = '';
  int Id;

  @override
  _ActivteState createState() => _ActivteState();
}

class _ActivteState extends State<Activtes> {
  late Future<List<Activity>> futureActivity;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy ss:mm:HH");
  bool seepersonspage = false;

  @override
  void initState() {
    super.initState();
    futureActivity = NetworkMethod.getActivityData(widget.Role, widget.Id);
    if (widget.Role == 'Admin') {
      seepersonspage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<Activity>>(
            future: futureActivity,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Activity> activity = snapshot.data!;
                return ListView.builder(
                    itemCount: activity.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, right: 20.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        activity[index].Headline,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(
                                          activity[index].Date,
                                          style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: Visibility(
          visible: seepersonspage,
          child: FloatingActionButton(
            onPressed: () {

            },
            tooltip: 'Tilføj Aktiviteter',
            child: const Icon(Icons.add),
          ),
        ));
  }
}
