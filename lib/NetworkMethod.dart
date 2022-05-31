import 'package:http/http.dart' as http;
import 'package:internship/Model/Person.dart';
import 'package:internship/Model/Activty.dart';
import 'package:internship/Model/ActivityStatus.dart';
import 'package:internship/Model/Group.dart';
import 'package:internship/Model/GroupOfPeople.dart';
import 'package:internship/Model/ActivityAndGroupsOfPeople.dart';
import 'package:internship/Model/Status.dart';
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

  Future<Person> changePerson(
      int id, String mail, String name, String password, String telephonenumber, String internship, String school, String role) async {
    final response = await http.put(Uri.parse(
       'http://localhost:5000/api/Persons/$id'),

    headers: <String, String>{
      'Content-Type': 'application/json',
    },

    body: jsonEncode(<String, String>{
    'name': name,
    'mail': mail,
    'password': password,
    'telephonenumber': telephonenumber,
    'internship': internship,
    'school': school,
    'role': role
    }),
    );

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
    throw Exception('Fail');

    }
  }

  Future<ActivityStatus> getactivity (int activityId, int personid) async{
    print('http://localhost:5000/api/ActivityStatuses/StatusActivityWithThatActivityAndPerson?activityId=$activityId&personId=$personid');
    final response = await http.get(Uri.parse('http://localhost:5000/api/ActivityStatuses/StatusActivityWithThatActivityAndPerson?activityId=$activityId&personId=$personid'));

    if(response.statusCode == 200 ){
      return ActivityStatus.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('getactivity');
    }
  }
  
  Future<ActivityStatus> changeAnswer(int id, int personid, String answer) async{
    final response = await http.put(Uri.parse('http://localhost:5000/api/ActivityStatuses/$id?personId=$personid&stringToChangeTo=$answer'));

    if(response.statusCode == 200){
      return ActivityStatus.fromJson(jsonDecode(response.body));
    }
    throw Exception('changeAnswer');
  }

  Future<List<Group>> getAllGroups() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/Groups'));

    if(response.statusCode == 200) {
      List jsonresponse = jsonDecode(response.body);
      return jsonresponse.map((group) => Group.fromJson(group)).toList();
    }else{
      throw Exception('getAllGroups');
    }
  }

  Future<http.Response> deleteGroup(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:5000/api/Groups/$id'));

    return response;
  }

  Future<Group> createGroup(String name) async {
    final response = await http.post(Uri.parse('http://localhost:5000/api/Groups'),
    headers: <String, String>{
      'Content-Type': 'application/json'
    },

    body: jsonEncode(<String, String>{
    'name': name,
    }),
    );

        if(response.statusCode == 201){
          return Group.fromJson(jsonDecode(response.body));
        }
        else {
          throw Exception('createGroup');
        }
  }

  Future<GroupOfPeople> addGroupOfPeople(int groupId, int personId) async{
    final response = await http.post(Uri.parse('http://localhost:5000/api/GroupsOfPeople?groupId=$groupId&personId=$personId'));

    if(response.statusCode == 201) {
      return GroupOfPeople.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('addGroupOfPeople');
    }
  }

Future <List<ActivityAndGroupsOfPeople>> PostActivityAndGroupsOfPeople(int activityId, int groupId) async {

    final response = await http.post(Uri.parse('http://localhost:5000/api/ActivityAndGroupsOfPeople?activityId=$activityId&groupId=$groupId'));

    if(response.statusCode == 201) {
      List jsonresponse = jsonDecode(response.body);
      return jsonresponse.map((activityAndGroupsOfPeople) => ActivityAndGroupsOfPeople.fromJson(activityAndGroupsOfPeople)).toList();
      print(response.body);
    } else{
      throw Exception('PostActivityAndGroupsOfPeople');
    }
}

Future<List<ActivityStatus>> getActivityStatusByActivity(int activityId) async {
    print('http://localhost:5000/api/ActivityStatuses/Activities?activityId=$activityId');
    final response = await http.get(Uri.parse('http://localhost:5000/api/ActivityStatuses/Activities?activityId=$activityId'));

    if(response.statusCode == 200){
      List jsonresponse = jsonDecode(response.body);
      return jsonresponse.map((getactivityStatusByActivity) => ActivityStatus.fromJson(getactivityStatusByActivity)).toList();
    } else{
      throw Exception('getActivityStatusByActivity');
    }
}

Future<Status> getStatusById(int id) async{
    print('http://localhost:5000/api/Statuses/$id');
    final response = await http.get(Uri.parse('http://localhost:5000/api/Statuses/$id'));

    if(response.statusCode == 200){
      return Status.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('getStatusById');
    }
}

Future<Person> getPersonById(int id) async {
    print('http://localhost:5000/api/Persons/$id');
    final response = await http.get(Uri.parse('http://localhost:5000/api/Persons/$id'));

    if(response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('getPersonById');
    }
}

Future<List<GroupOfPeople>> getByGroupId(int groupId) async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/GroupsOfPeople/Groups?groupId=$groupId'));

    if(response.statusCode == 200){
      List jsonresponse = jsonDecode(response.body);
      return jsonresponse.map((getbygroupid) => GroupOfPeople.fromJson(getbygroupid)).toList();
    } else{
      throw Exception('fail');
    }
}

Future<ActivityStatus> postPersonToActivity(int activityId, int personId)async {
    final response = await http.post(Uri.parse('http://localhost:5000/api/ActivityStatuses?activityId=$activityId&personId=$personId'));

    if(response.statusCode == 201){
      return ActivityStatus.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('fail');
    }
}



}
