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
  var personId = [];
  var status = [];
  List<Person> name = <Person>[];

  getStatusById(){
    for (int id in statusId) {
      viewmodel.getStatusById(id).then((value) =>
      {
        personId.add(value.personId),
        status.add(value.myStatus),
        print(value)
      });
  };
  }

  getPersonById() {
    print('detet');
    for (var id in personId) {
      print('asdasd');
      viewmodel.getPersonById(id).then((value) => {

        name.add(value),
        print(value.Id)
      });
    };
  }

  tryToReload() async {
     futureActivityStatus =  viewmodel.getOneActivity(widget.ActivityId, widget.userId);

     await viewmodel.getOneActivity(widget.ActivityId, widget.userId).then((value) {

      id = value.Id;
    });

     viewmodel.getActivityStatusByActivity(widget.ActivityId).then((value) => {
      value.forEach((element) {
        print(element);
        statusId.add(element.statusId);
        getStatusById();
        getPersonById();
      }),



    });

  }

  @override
   void initState() {
    super.initState();

    tryToReload();
  }

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
                style: const TextStyle(),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              Wrap(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      const String comming = 'I am attending';
                      viewmodel.changeAnswer(id, widget.userId, comming);
                    },
                    child: const Text(
                      'Tilmeld',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      const String iamnotcooming = 'I am not attending';
                      viewmodel.changeAnswer(id, widget.userId, iamnotcooming);
                    },
                    child: const Text(
                      'Frameld',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      const String idontknow = 'I have not answered';
                      viewmodel.changeAnswer(id, widget.userId, idontknow);
                    },
                    child: const Text(
                      'Ved ikke',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                  ),
                ],
              )
            ],
          ),

        ],
      ),
    ));
  }
}
