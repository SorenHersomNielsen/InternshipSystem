import 'package:flutter/material.dart';
import 'package:internship/Widget/Profile.dart';
import 'package:internship/ActivtiesPage.dart';
import 'package:internship/PersonsPage.dart';

class ProfilePage extends StatefulWidget {
  final String email;
  final String password;
  final String Role;
  final int Id;

  const ProfilePage(
      {Key? key,
      required this.email,
      required this.password,
      required this.Role,
      required this.Id})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text(
                  'Min profil',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onTap: () {},
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
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonsPage(
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
        body: Profile(email: widget.email, password: widget.password));
  }
}
