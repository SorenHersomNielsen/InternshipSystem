import 'package:flutter/material.dart';
import 'package:internship/HomePage.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:internship/Model/Person.dart';

class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  final _formkey = GlobalKey<FormState>();
  dynamic _email;
  dynamic _password;
  bool check = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          height: 300,
          width: 550,
          color: Colors.white,
          child: Form(
            key: _formkey,
            child: Column(children: <Widget>[
               Text(
                'Log på',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.red
                ),
              ),
               SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
                onChanged: (value) {
                  _email = value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'mangle email';
                  }
                  return null;
                },
              ),
               SizedBox(height: 20),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  }),
               SizedBox(height: 10),
            SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child:  Text(
                  'Log på',
                 style: TextStyle(
                   color: Colors.white,
                 ),
                ),
                onPressed: () {
                  //bool check = false;
                  NetworkMethod.fetchPerson(_email,_password).then((value) => {

                    if(value != null) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  ),
                    }
                      else{
                      print('ingen adgang')
                      }
                  });

                },
              ),
            )
            ]),
          ),
        ) ,
      ),
    );
  }
}
