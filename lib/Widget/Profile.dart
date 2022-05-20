import 'package:flutter/material.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/NetworkMethod.dart';

class Profile extends StatefulWidget {

   Profile({Key? key, required this.password, required this.email}) : super(key: key);

  String email = '';
  String password = '';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late Future<Person> futureAlbum;
  late String _newpassword;
  late String _oldpassword;

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  final snackbarGood = const SnackBar(
    content: Text('Kodeord er skift'),
    backgroundColor: Colors.green,
  );

  @override
  void initState() {
    super.initState();
    futureAlbum = NetworkMethod.getPersonData(widget.email, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<Person>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text(
                        snapshot.data!.Name,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                       Text(
                        snapshot.data!.Mail,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                       Text(
                         snapshot.data!.TelephoneNumber,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                       Text(
                         snapshot.data!.School,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        snapshot.data!.Internship,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        snapshot.data!.Role,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Nuværende kodeord'),
                        onChanged: (value) {
                          _oldpassword  = value;
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'være venlig at skrive dit kodeord';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 5.0)
                              ), labelText: 'Nye kodeord'),
                          onChanged: (value) {
                            _newpassword = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'være venlig at skrive dit nye kodeord';
                            }
                            return null;
                          }),
                      const SizedBox(height: 10.0),
                      TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.red),
                        child:  const Text(
                          'Skift kodeord',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          NetworkMethod.changePassword(snapshot.data!.Mail, _oldpassword, _newpassword).then((value) => {

                            if(value == 'Password changes'){
                              ScaffoldMessenger.of(context).showSnackBar(snackbarGood)
                            } else{
                              ScaffoldMessenger.of(context).showSnackBar(snackbarFail)
                            }

                          });

                          },
                      ),
                    ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}