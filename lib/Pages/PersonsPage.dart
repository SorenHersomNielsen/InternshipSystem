import 'package:flutter/material.dart';
import 'package:internship/Widget/Persons.dart';
import 'package:internship/Pages/ProfilePage.dart';
import 'package:internship/Pages/ActivtiesPage.dart';
import 'package:internship/Pages/GroupsPage.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage(
      {Key? key,
      required this.Id,
      required this.Role,
      required this.password,
      required this.email})
      : super(key: key);

  final String email;
  final String password;
  final String Role;
  final int Id;

  @override
  _PersonsPageState createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  bool seepersonspage = false;

  @override
  void initState() {
    super.initState();

    if (widget.Role == 'Admin') {
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
                child: Text(''),
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
                            Role: widget.Role,
                            Id: widget.Id)),
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
                            role: widget.Role,
                            id: widget.Id,
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
                  onTap: () {},
                ),
              ),
              Visibility(
                visible: seepersonspage,
                child: ListTile(
                  title: const Text(
                    'Grupper',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupsPage(
                              Id: widget.Id,
                              Role: widget.Role,
                              email: widget.email,
                              password: widget.password)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        body: Persons(
            role: widget.Role,
            id: widget.Id,
            email: widget.email,
            password: widget.password));
  }
}
