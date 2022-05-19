import 'package:flutter/material.dart';
import 'package:internship/Widget/Profile.dart';
import 'package:internship/ActivtiesPage.dart';

class ProfilePage extends StatefulWidget{

  final String email;
  final String password;

   ProfilePage({Key? key, required this.email, required this.password }) : super(key: key);

@override
_ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Min Profil'
        ),
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
                    'Min Profil',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ActivtesPage()),
                  );
                },
              ),
            ],
          ),
        ),
      body: Profile(email: widget.email,password: widget.password)
    );
  }

}


