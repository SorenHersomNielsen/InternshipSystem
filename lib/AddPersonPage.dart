import 'package:flutter/material.dart';
import 'package:internship/ProfilePage.dart';
import 'package:internship/ActivtiesPage.dart';
import 'package:internship/PersonsPage.dart';
import 'package:internship/Widget/AddPerson.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage(
      {Key? key,
      required this.id,
      required this.role,
      required this.password,
      required this.email})
      : super(key: key);

  final String email;
  final String password;
  final String role;
  final int id;

  @override
  _AddPersonPageState createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  bool seepersonspage = false;

  @override
  void initState() {
    super.initState();

    if (widget.role == 'Admin') {
      seepersonspage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.blue),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text(
                  'Min profil',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            email: widget.email,
                            password: widget.password,
                            Role: widget.role,
                            Id: widget.id)),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Aktiviteter',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivtesPage(
                            role: widget.role,
                            id: widget.id,
                            email: widget.email,
                            password: widget.password)),
                  );
                },
              ),
              Visibility(
                visible: seepersonspage,
                child: ListTile(
                  title: const Text(
                    'Personer',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonsPage(
                              Role: widget.role,
                              Id: widget.id,
                              email: widget.email,
                              password: widget.password)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        body: AddPerson());
  }
}
