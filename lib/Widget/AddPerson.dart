import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {

  final viewmodel =  Viewmodel();
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _mail;
  late String _password;
  late String _telephoneNumber;
  late String _internship;
  late String _school;

  String dropdownValue = 'Bruger';

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  final snackbarGood = const SnackBar(
    content: Text('Person er oprettet'),
    backgroundColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Navn'),
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive persons navn';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Mail'),
                    onChanged: (value) {
                      _mail = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive persons mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Kodeord'),
                    onChanged: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive persons kodeord';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefonnummer'),
                    onChanged: (value) {
                      _telephoneNumber = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive persons telefonnummer';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Praktiksted'),
                    onChanged: (value) {
                      _internship = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive persons praktiksted';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Skole'),
                    onChanged: (value) {
                      _school = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive persons Skole';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      'Opret person',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        viewmodel.createPerson(
                                _name,
                                _mail,
                                _password,
                                _telephoneNumber,
                                _internship,
                                _school,
                                dropdownValue)
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
                      };
                    },
                  ),
                ]))));
  }
}
