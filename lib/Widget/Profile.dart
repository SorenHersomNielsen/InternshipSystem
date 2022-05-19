import 'package:flutter/material.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/NetworkMethod.dart';

class Profile extends StatefulWidget {

   Profile({Key? key, required this.password, required this.email}) : super(key: key);

  String email = '';
  String password = '';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late Future<Person> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = NetworkMethod.getPersonData(widget.email, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(padding: const EdgeInsets.all(20),
          child: FutureBuilder<Person>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text(
                        snapshot.data!.Role,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),

                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'søren@test.dk',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'dk',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        '112233556556105',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),

                    ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}