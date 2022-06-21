import 'package:flutter/material.dart';
import 'package:internship/Pages/PersonsPage.dart';
import 'package:internship/Pages/ProfilePage.dart';
import 'package:internship/Pages/ActivtiesPage.dart';
import 'package:internship/Pages/GroupsPage.dart';
import 'package:internship/Widget/AddGroupToActivity.dart';

class AddGroupToActivityPage extends StatefulWidget {
  const AddGroupToActivityPage(
      {Key? key,
        required this.role,
        required this.id,
        required this.email,
        required this.password,
      required this.activityId})
      : super(key: key);

  final String email;
  final String password;
  final String role;
  final int id;
  final int activityId;

  @override
  _AddGroupToActivityPage createState() => _AddGroupToActivityPage();
}

class _AddGroupToActivityPage extends State<AddGroupToActivityPage> {
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
                child: Text(''),
              ),
              ListTile(
                title: const Text(
                  'Min profil',
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
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
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonsPage(
                              Id: widget.id,
                              Role: widget.role,
                              email: widget.email,
                              password: widget.password)),
                    );
                  },
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
                              Id: widget.id,
                              Role: widget.role,
                              email: widget.email,
                              password: widget.password)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      body: addGroupToActivity(activityId: widget.activityId, email: widget.email, password: widget.password, role: widget.role, id: widget.id),
    );
  }
}