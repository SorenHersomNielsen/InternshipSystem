import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';
import 'package:internship/Model/Group.dart';

class Groups extends StatefulWidget {
  const Groups(
      {Key? key,
        required this.id,
        required this.role,
        required this.email,
        required this.password})
      : super(key: key);

  final String email;
  final String password;
  final String role;
  final int id;

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  late Future<List<Group>> futureGroups;

  final viewmodel =  Viewmodel();
  late String name;

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );
  final snackbarGood = const SnackBar(
    content: Text('gruppen er oprettet'),
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
                                      child: const Icon(Icons.delete),
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        viewmodel.deleteGroup(groups[index].Id).then((value) => {
                                          if (value.statusCode == 200)
                                            {
                                              setState(() {
                                                futureGroups =
                                                    viewmodel.getAllGroups();
                                              })
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                  snackbarFail)
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('opret gruppe'),
              content: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5.0)),
                      labelText: 'gruppens navn'),
                  onChanged: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'være venlig at skrive dit gruppens navn';
                    }
                    return null;
                  }),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => {
                      viewmodel.createGroup(name).then((value) => {
                        if(value != null){
                          Navigator.pop(context, 'OK'),
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              snackbarGood),
                          setState((){
                            futureGroups = viewmodel.getAllGroups();
                          })
                        } else{
                          Navigator.pop(context, 'OK'),
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              snackbarFail)
                        }
                      })
                     },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        tooltip: 'Tilføj Gruppe',
        child: const Icon(Icons.add),
      ),
    );
  }
}