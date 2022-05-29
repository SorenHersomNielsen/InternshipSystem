import 'package:flutter/material.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/Pages/AddPersonPage.dart';
import 'package:internship/Viewmodel.dart';
import 'package:internship/Pages/EditPersonPage.dart';

class AddPeopleToGroup extends StatefulWidget {
  AddPeopleToGroup({Key? key, required this.groupId}) : super(key: key);

  final int groupId;

  @override
  _AddPeopleToGroupState createState() => _AddPeopleToGroupState();
}

class _AddPeopleToGroupState extends State<AddPeopleToGroup> {
  late Future<List<Person>> futureActivity;

  final viewmodel = Viewmodel();

  var listofid = [];

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  @override
  void initState() {
    super.initState();
    futureActivity = viewmodel.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Stack(
            children: [
              FutureBuilder<List<Person>>(
                future: futureActivity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Person> persons = snapshot.data!;
                    return ListView.builder(
                        itemCount: persons.length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            persons[index].Name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Text(
                                              persons[index].Mail,
                                              style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
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
                                              final String person =
                                                  persons[index].Name;
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    'Du har vælgt $person'),
                                                backgroundColor: Colors.blue,
                                              );
                                              listofid.add(persons[index].Id);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                          ),
                                        ],
                                      )
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
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: <Widget>[
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text(
                          'Tilføj personer til gruppen',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          for(var id in listofid){
                            viewmodel.addGroupOfPeople(widget.groupId, id);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text(
                          'Ryd listen',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          listofid.clear();
                          final snackBar = SnackBar(
                            content: Text('listen er slettet'),
                            backgroundColor: Colors.blue,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
