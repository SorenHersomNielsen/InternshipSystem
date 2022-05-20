import 'package:flutter/material.dart';
import 'package:internship/Widget/Persons.dart';

class PersonsPage extends StatefulWidget{

  PersonsPage({Key? key}) : super(key: key);

  @override
  _PersonsPageState createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage>{

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
                  style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                onTap: () {

                },
              ),
              ListTile(
                title: const Text(
                  'Aktiviteter',
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                onTap: () {
                  //Navigator.push(
                    //context,
                   // MaterialPageRoute(builder: (context) => ActivtesPage(Role: widget.Role, Id: widget.Id)),
                  //);
               },
              ),

            ],
          ),
        ),
        body: Persons()
    );
  }
}