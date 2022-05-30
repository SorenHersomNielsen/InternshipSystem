import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';
import 'package:internship/Model/Group.dart';
import 'package:internship/Pages/AddPeopleToGroupPage.dart';
import 'package:internship/Pages/ActivtiesPage.dart';

class addGroupToActivity extends StatefulWidget {
  const addGroupToActivity(
      {Key? key,
      required this.activityId,
      required this.role,
      required this.id,
      required this.email,
      required this.password})
      : super(key: key);

  final int activityId;
  final String email;
  final String password;
  final String role;
  final int id;

  @override
  _addGroupToActivityState createState() => _addGroupToActivityState();
}

class _addGroupToActivityState extends State<addGroupToActivity> {
  late Future<List<Group>> futureGroups;

  final viewmodel = Viewmodel();

  var personId = [];

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  final snackbarGood = const SnackBar(
    content: Text('Gruppen er tilføjet til aktiviteten'),
    backgroundColor: Colors.green,
  );

  @override
  void initState() {
    super.initState();
    futureGroups = viewmodel.getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Group>>(
          future: futureGroups,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Group> groups = snapshot.data!;
              return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 20.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)),
                          color: Colors.grey.shade400,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      groups[index].Name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    RawMaterialButton(
                                      child: const Icon(Icons.add),
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        viewmodel.PostActivityAndGroupsOfPeople(
                                                widget.activityId,
                                                groups[index].Id)
                                            .then((value) => {
                                                  if (value != null)
                                                    {

                                                      viewmodel.getByGroupId(groups[index].Id).then((value) => {
                                                        
                                                       value.forEach((element) {
                                                         personId.add(element.personId);
                                                       }),

                                                        for(int id in personId){
                                                          viewmodel.postPersonToActivity(widget.activityId, id),
                                                        },

                                                      }),



                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackbarGood),
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ActivtesPage(
                                                                    id: widget
                                                                        .id,
                                                                    role: widget
                                                                        .role,
                                                                    email: widget
                                                                        .email,
                                                                    password: widget
                                                                        .password)),
                                                      ),
                                                    }
                                                });
                                      },
                                    )
                                  ],
                                )
                              ],
                            )
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
    );
  }
}
