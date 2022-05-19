import 'package:flutter/material.dart';

class ActivtesPage extends StatefulWidget{

  const ActivtesPage({Key? key}) : super(key: key);

  @override
  _ActivtesPageState createState() => _ActivtesPageState();
}

class _ActivtesPageState extends State<ActivtesPage>{

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
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                onTap: () {

                },
              ),
            ],
          ),
        ),
    );
  }

}