import 'package:flutter/material.dart';
import 'package:internship/Pages/ProfilePage.dart';
import 'package:internship/Pages/PersonsPage.dart';
import 'package:internship/Widget/SeeActivity.dart';
import 'package:internship/Pages/GroupsPage.dart';
import 'package:internship/Pages/ActivtiesPage.dart';

class SeeActivityPage extends StatefulWidget {
  const SeeActivityPage(
      {Key? key,
        required this.role,
        required this.id,
        required this.email,
        required this.password,
        required this.Activityid,
        required this.headline,
        required this.date
      })
      : super(key: key);

  final String email;
  final String password;
  final String role;
  final int id;
  final int Activityid;
  final String date;
  final String headline;

  @override
  _SeeActivityPageState createState() => _SeeActivityPageState();
}

class _SeeActivityPageState extends State<SeeActivityPage> {
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
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
      body: SeeActivity(userId: widget.id, ActivityId: widget.Activityid,headline: widget.headline,date: widget.date),
    );
  }
}
