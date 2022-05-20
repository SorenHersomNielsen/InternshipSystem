import 'package:flutter/material.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:internship/Model/Person.dart';

class Persons extends StatefulWidget{

  Persons({Key? key}) : super(key: key);

  @override
  _PersonsState createState() => _PersonsState();
}

class _PersonsState extends State<Persons>{
  late Future <List<Person>> futureActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = NetworkMethod.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Person>>(
          future: futureActivity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Person> persons = snapshot.data!;
              return ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {

                      },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      persons[index].Name,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                          ],
                        ),
                      ),
                    );
                  }
              );
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