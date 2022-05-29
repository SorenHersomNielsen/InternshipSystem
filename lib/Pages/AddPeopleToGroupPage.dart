import 'package:flutter/material.dart';
import 'package:internship/Pages/ProfilePage.dart';
import 'package:internship/Pages/ActivtiesPage.dart';
import 'package:internship/Pages/PersonsPage.dart';
import 'package:internship/Widget/Groups.dart';
import 'package:internship/Widget/AddPeopleToGroup.dart';

class AddPeopleToGroupPage extends StatefulWidget {
  const AddPeopleToGroupPage(
      {Key? key,
        required this.userId,
        required this.Role,
        required this.password,
        required this.email,
        required this.groupID
      })
      : super(key: key);

  final String email;
  final String password;
  final String Role;
  final int userId;
  final int groupID;

  @override
  _AddPeopleToGroupState createState() => _AddPeopleToGroupState();
}

class _AddPeopleToGroupState extends State<AddPeopleToGroupPage> {
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
                            Id: widget.userId)),
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
                            id: widget.userId,
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
                        color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonsPage(
                              Role: widget.Role,
                              Id: widget.userId,
                              email: widget.email,
                              password: widget.password,

                          )),
                    );
                  },
                ),
              ),
              Visibility(
                visible: seepersonspage,
                child: ListTile(
                  title: const Text(
                    'Grupper',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onTap: () {},
                ),
              ),

            ],
          ),
        ),
      body: AddPeopleToGroup(groupId: widget.groupID),
);
  }
}