import 'package:flutter/material.dart';
import 'package:internship/Widget/Activties.dart';
import 'package:internship/Pages/ProfilePage.dart';
import 'package:internship/Pages/PersonsPage.dart';
import 'package:internship/Widget/Profile.dart';
import 'package:internship/Widget/SeeActivity.dart';

class SeeActivityPage extends StatefulWidget {
  const SeeActivityPage(
      {Key? key,
        required this.role,
        required this.id,
        required this.email,
        required this.password})
      : super(key: key);

  final String email;
  final String password;
  final String role;
  final int id;

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
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onTap: () {},
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
            )
          ],
        ),
      ),
      body: SeeActivity(userId: widget.id,),
    );
  }
}
