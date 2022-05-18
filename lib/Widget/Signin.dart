import 'package:flutter/material.dart';
import 'package:internship/HomePage.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:internship/Model/Person.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  dynamic _email;
  dynamic _password;
  bool check = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          width: 550,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
               const Text(
                'Log på',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.red
                ),
              ),
               const SizedBox(height: 20),
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
               const SizedBox(height: 20),
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
               const SizedBox(height: 10),
            SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child:  const Text(
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
