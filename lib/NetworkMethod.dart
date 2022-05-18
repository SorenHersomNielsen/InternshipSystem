import 'package:http/http.dart' as http;
import 'package:internship/Model/Person.dart';
import 'dart:async';
import 'dart:convert';

class NetworkMethod{

  static Future<Person?> fetchPerson(String email, String password) async {

    const String replacewith ='%40';
    String Replace;

    if(email.contains('ø')){
       Replace = email.replaceAll('ø', '%C3%B8');
    }

     Replace = email.replaceAll('@', replacewith);

    final response = await http
        .get(Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=$Replace&passWord=$password'));

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body)[0]);

    } else {
      return null;
    }
  }
}