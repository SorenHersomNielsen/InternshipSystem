import 'package:flutter/material.dart';
import 'package:internship/Widget/Persons.dart';
import 'package:internship/PersonsPage.dart';
import 'package:internship/Widget/AddActivity.dart';

class AddActivityPage extends StatefulWidget {
  AddActivityPage({Key? key, required this.Role }) : super(key: key);

   String Role ='';

  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {

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

                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Aktiviteter',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onTap: () {
                  //Navigator.push(
                  //context,
                  // MaterialPageRoute(builder: (context) => ActivtesPage(Role: widget.Role, Id: widget.Id)),
                  //);
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
                      MaterialPageRoute(builder: (context) => PersonsPage()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        body: AddActivity(restorationId: 'main',));
  }
}
