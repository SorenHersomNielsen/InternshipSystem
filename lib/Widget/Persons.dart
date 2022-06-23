import 'package:flutter/material.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/Pages/AddPersonPage.dart';
import 'package:internship/Viewmodel.dart';
import 'package:internship/Pages/EditPersonPage.dart';

class Persons extends StatefulWidget {
  const Persons(
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
  _PersonsState createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  late Future<List<Person>> futureActivity;

  final viewmodel =  Viewmodel();

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
                                Wrap(
                                  children: <Widget>[
                                    RawMaterialButton(
                                      child: const Icon(Icons.edit),
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditPersonsPage(
                                                Id: persons[index].Id,
                                                Role: widget.role,
                                                password: persons[index].Password,
                                                email: persons[index].Mail
                                              )),
                                        );


                                      },
                                    ),

                                    RawMaterialButton(
                                      child: const Icon(Icons.delete),
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        viewmodel.deletePerson(
                                            persons[index].Id.toString())
                                            .then((value) => {
                                          if (value.statusCode == 200)
                                            {
                                              setState(() {
                                                futureActivity =
                                                    viewmodel.getPersons();
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPersonPage(
                    id: widget.id,
                    role: widget.role,
                    password: widget.password,
                    email: widget.email)),
          );
        },
        tooltip: 'Tilføj person',
        child: const Icon(Icons.add),
      ),
    );
  }
}
