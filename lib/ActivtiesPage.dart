import 'package:flutter/material.dart';
import 'package:internship/Widget/Activties.dart';

class ActivtesPage extends StatefulWidget {
  ActivtesPage({Key? key, required this.Role, required this.Id})
      : super(key: key);

  String Role = '';
  int Id;

  @override
  _ActivtesPageState createState() => _ActivtesPageState();
}

class _ActivtesPageState extends State<ActivtesPage> {
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
              onTap: () {},
            ),
            ListTile(
              title: Text(
                widget.Role,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Activtes(Role: widget.Role, Id: widget.Id),
    );
  }
}
