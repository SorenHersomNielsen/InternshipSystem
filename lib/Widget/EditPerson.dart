import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';
import 'package:internship/Model/Person.dart';

class EditPerson extends StatefulWidget {
   EditPerson({Key? key, required this.id, required this.mail, required this.password}) : super(key: key);

  int id;
  String mail;
  String password;

  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {

  final viewmodel =  Viewmodel();

  final _formKey = GlobalKey<FormState>();
  late Future<Person> futureAlbum;

  String dropdownValue = 'Bruger';

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  final snackbarGood = const SnackBar(
    content: Text('Person er ændret'),
    backgroundColor: Colors.green,
  );

  @override
  void initState() {
    super.initState();
    futureAlbum = viewmodel.getPersonData(widget.mail, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Person>(
          key: _formKey,
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               String name = snapshot.data!.Name;
               String mail = snapshot.data!.Mail;
               String password = snapshot.data!.Password;
               String telephoneNumber = snapshot.data!.TelephoneNumber;
               String internship = snapshot.data!.Internship;
               String school = snapshot.data!.School;
               String dropdownValue = snapshot.data!.Role;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(), labelText: name),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(), labelText: mail),
                      onChanged: (value) {
                        mail = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(), labelText: password),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(), labelText: telephoneNumber),
                      onChanged: (value) {
                        telephoneNumber = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(), labelText: internship),
                      onChanged: (value) {
                        internship = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(), labelText: school),
                      onChanged: (value) {
                        school = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.red),
                      underline: Container(
                        height: 2,
                        color: Colors.red,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Bruger', 'Admin']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'Ændre Person',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        viewmodel.changePerson(
                            snapshot.data!.Id, mail, name, password, telephoneNumber, internship,school, dropdownValue)
                            .then((value) => {
                          if (value != null)
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbarGood)
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbarFail)
                            }
                        });
                      },
                    ),
                  ]);
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