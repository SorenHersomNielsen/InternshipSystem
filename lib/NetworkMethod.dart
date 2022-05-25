import 'package:http/http.dart' as http;
import 'package:internship/Model/Person.dart';
import 'package:internship/Model/Activty.dart';
import 'dart:async';
import 'dart:convert';

class NetworkMethod {

  Future<Person?> fetchPerson(String email, String password) async {
    final response = await http.get(Uri.parse(
        'http://localhost:5000/api/Persons/OnePerson?mail=$email&passWord=$password'));

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body)[0]);
    } else {
      return null;
    }
  }

   Future<Person> getPersonData(String email, String password) async {
    final response = await http.get(Uri.parse(
        'http://localhost:5000/api/Persons/OnePerson?mail=$email&passWord=$password'));

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to load person');
    }
  }

   Future<List<Activity>> getActivityData(String Role, int Id) async {
    dynamic response = "";

    if (Role.toString().toLowerCase() == 'admin') {
      response =
          await http.get(Uri.parse('http://localhost:5000/api/Activities'));
    } else {
      response = await http.get(Uri.parse(
          'http://localhost:5000/api/Activities/OnePersonAndTheirActivities?personId=$Id'));
    }

    if (response.statusCode == 200) {
      List jsonresponse = jsonDecode(response.body);
      return jsonresponse
          .map((activity) => Activity.fromJson(activity))
          .toList();
    } else {
      throw Exception('Failed to load activity');
    }
  }

   Future<String> changePassword(
      String mail, String oldPassword, String newPassword) async {
    final response = await http.put(Uri.parse(
        'http://localhost:5000/api/Persons/PutPath?email=$mail&oldPassWord=$oldPassword&newPassWord=$newPassword'));

    if (response.statusCode == 200) {
      return 'Password changes';
    } else {
      return 'somethings went wrong';
    }
  }

   Future<List<Person>> getPersons() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/api/Persons'));

    if (response.statusCode == 200) {
      List jsonresponse = jsonDecode(response.body);
      return jsonresponse.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Failed to load Persons');
    }
  }

   Future<http.Response> deletePerson(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://localhost:5000/api/Persons/$id'),
    );
    return response;
  }

   Future<Person> createPerson(
      String name,
      String mail,
      String password,
      String telephoneNumber,
      String internship,
      String school,
      String role) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/Persons'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'mail': mail,
        'password': password,
        'telephoneNumber': telephoneNumber,
        'internship': internship,
        'school': school,
        'role': role
      }),
    );

    if (response.statusCode == 201) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create person');
    }
  }

  Future<Activity> createActivity(String headline, DateTime date) async{

    final response = await http.post(Uri.parse('http://localhost:5000/api/Activities'),
    headers: <String, String>{
    'Content-Type': 'application/json',
    },

    body: jsonEncode(<String, String>{
      'headline': headline,
       'date': date.toIso8601String()
    }),
    );

    if(response.statusCode == 201){
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create activity');
    }
  }
}
