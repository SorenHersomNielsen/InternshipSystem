import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';
import 'package:internship/Model/ActivityStatus.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/Model/ActivityStatus.dart';

class SeeActivity extends StatefulWidget {
  const SeeActivity(
      {Key? key,
      required this.userId,
      required this.ActivityId,
      required this.date,
      required this.headline})
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

  late Future<ActivityStatus> futureActivityStatus;
  late int id;
  var statusId = [];
  List<int> personId = <int>[];
  var status = [];
  List<Person> name = <Person>[];

  getStatusById() async {
    for (var id in statusId) {
      await viewmodel.getStatusById(id).then((value) => {
            personId.add(value.personId),
            status.add(value.myStatus),
          });
    }
    ;
  }

  getPersonById() async {
    for (var id in personId) {
      await viewmodel.getPersonById(id).then((value) => {
            name.add(value),
          });
    }
    ;
  }

  tryToReload() async {
    //futureActivityStatus =  viewmodel.getOneActivity(widget.ActivityId, widget.userId);

    await viewmodel
        .getOneActivity(widget.ActivityId, widget.userId)
        .then((value) {
      id = value.Id;
    });

    await viewmodel
        .getActivityStatusByActivity(widget.ActivityId)
        .then((value) => {
              value.forEach((element) {
                statusId.add(element.statusId);
              }),
            });

    await getStatusById();
    await getPersonById();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: tryToReload(),
              builder: (context, snapshot) {
                return Row(
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
                          style: const TextStyle(),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                const String comming = 'I am attending';
                                viewmodel.changeAnswer(
                                    id, widget.userId, comming);
                                setState((){
                                  statusId.clear();
                                  status.clear();
                                  personId.clear();
                                  name.clear();
                                  _SeeActivityState();
                                });
                              },
                              child: const Text(
                                'Tilmeld',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                const String iamnotcooming =
                                    'I am not attending';
                                viewmodel.changeAnswer(
                                    id, widget.userId, iamnotcooming);
                                setState((){
                                  statusId.clear();
                                  status.clear();
                                  personId.clear();
                                  name.clear();
                                  _SeeActivityState();
                                });
                              },
                              child: const Text(
                                'Frameld',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                const String idontknow = 'I have not answered';
                                viewmodel.changeAnswer(
                                    id, widget.userId, idontknow);
                                setState((){
                                  statusId.clear();
                                  status.clear();
                                  personId.clear();
                                  name.clear();
                                  _SeeActivityState();
                                });
                              },
                              child: const Text(
                                'Ved ikke',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                        child: Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                child: ListView.builder(
                    itemCount: personId.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          children: <Widget>[
                            const SizedBox(height: 20),

                            Text(name[index].Name,
                                textAlign: TextAlign.left
                            ),
                            const SizedBox(height: 5),
                            Text(
                              status[index],
                              textAlign: TextAlign.left,
                            )


                          ]

                      );
                    })
                )
                            ))
                  ],
                );
              },
            )));
  }
}
