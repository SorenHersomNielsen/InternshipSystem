import 'package:http/http.dart' as http;
import 'package:internship/Model/Person.dart';
import 'package:internship/Model/Activty.dart';
import 'dart:async';
import 'dart:convert';

class NetworkMethod{

  static Future<Person?> fetchPerson(String email, String password) async {

    final response = await http
        .get(Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=$email&passWord=$password'));

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body)[0]);

    } else {
      return null;
    }
  }

  static Future<Person> getPersonData(String email, String password) async {

    final response = await http
        .get(Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=$email&passWord=$password'));

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body)[0]);

    } else {
      throw Exception('Failed to load person');
    }
  }


  static Future<Activity> getActivityData() async {

    final response = await http
        .get(Uri.parse('http://localhost:5000/api/Activities'));

    if (response.statusCode == 200) {
      return Activity.fromJson(jsonDecode(response.body)[0]);

    } else {
      throw Exception('Failed to load activity');
    }
  }
}