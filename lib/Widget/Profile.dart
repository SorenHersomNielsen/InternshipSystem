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
        body: Center(
          child: FutureBuilder<Person>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.Name);
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