import 'package:flutter/material.dart';
import 'package:internship/ProfilePage.dart';
import 'package:internship/NetworkMethod.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool check = false;

  final snackballfall = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 315,
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
                    return 'være venlig at skrive dit mail';
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
                      return 'være venlig at skrive dit password';
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
                  if (_formKey.currentState!.validate()) {
                    NetworkMethod.fetchPerson(_email,_password).then((value) => {

                      if(value != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage(email: _email, password: _password, Role: value.Role, Id: value.Id)),
                        ),
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(snackballfall)
                      }
                    });
                  };
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
