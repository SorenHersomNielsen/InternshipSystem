import 'package:http/http.dart' as http;
import 'package:internship/Model/Person.dart';
import 'dart:async';
import 'dart:convert';

class NetworkMethod{

  static Future<Person?> fetchPerson(email, password) async {
    print('network');

    final response = await http
        .get(Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=$email&ord=$password'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      print("god");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Person.fromJson(jsonDecode(response.body)[0]);
    } else {
      print("dårligt");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
      return null;
    }
  }

}