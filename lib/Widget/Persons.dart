import 'package:flutter/material.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/Widget/AddPerson.dart';

class Persons extends StatefulWidget {
  const Persons({Key? key}) : super(key: key);

  @override
  _PersonsState createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  late Future<List<Person>> futureActivity;

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  @override
  void initState() {
    super.initState();
    futureActivity = NetworkMethod.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Person>>(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      width: MediaQuery.of(context).size.width *
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                RawMaterialButton(
                                  child: const Icon(Icons.delete),
                                  padding: const EdgeInsets.all(15.0),
                                  shape: const CircleBorder(),
                                  onPressed: () {
                                    NetworkMethod.deletePerson(
                                            persons[index].Id.toString())
                                        .then((value) => {
                                              if (value.statusCode == 200)
                                                {
                                                  setState(() {
                                                    futureActivity =
                                                        NetworkMethod
                                                            .getPersons();
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPerson()),
          );
        },
        tooltip: 'Tilføj person',
        child: const Icon(Icons.add),
      ),
    );
  }
}
