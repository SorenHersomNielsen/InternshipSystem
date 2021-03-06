import 'package:internship/NetworkMethod.dart';
import 'package:internship/Model/Person.dart';
import 'package:internship/Model/Activty.dart';
import 'package:internship/Model/ActivityStatus.dart';
import 'package:internship/Model/Group.dart';
import 'package:internship/Model/GroupOfPeople.dart';
import 'package:internship/Model/ActivityAndGroupsOfPeople.dart';
import 'package:internship/Model/Status.dart';
import 'package:http/http.dart' as http;

class Viewmodel {
  final networkMethod =  NetworkMethod();

  Future<Person?> login(String email, String password) async {
    return await networkMethod.fetchPerson(email, password);
  }

  Future<Person> getPersonData(String email, String password){

    return networkMethod.getPersonData(email, password);
  }

  Future<String> changePassword(
      String mail, String oldPassword, String newPassword){
    return networkMethod.changePassword(mail, oldPassword, newPassword);
  }

  Future<Person> createPerson(
      String name,
      String mail,
      String password,
      String telephoneNumber,
      String internship,
      String school,
      String role) {
    
    return networkMethod.createPerson(name, mail, password, telephoneNumber, internship, school, role);
  }

  Future<http.Response> deletePerson(String id){
    return networkMethod.deletePerson(id);
  }

  Future<List<Person>> getPersons(){
    return networkMethod.getPersons();
  }

  Future<List<Activity>> getActivityData(String Role, int Id){
    return networkMethod.getActivityData(Role, Id);
  }

  Future<Activity> createActivity(String headline, DateTime date){
    return networkMethod.createActivity(headline, date);
  }

  Future<Person> changePerson( int id, String mail, String name, String password, String telephonenumber, String internship, String school, String role){
    return networkMethod.changePerson(id, mail, name, password, telephonenumber, internship, school, role);
  }

  Future<ActivityStatus> getOneActivity(int activityid, int personid){
    return networkMethod.getactivity(activityid, personid);
  }

  Future<ActivityStatus> changeAnswer(int id, int personid, String answer){
    return networkMethod.changeAnswer(id, personid, answer);
  }

  Future<List<Group>> getAllGroups(){
    return networkMethod.getAllGroups();
  }

  Future<http.Response> deleteGroup(int id){
    return networkMethod.deleteGroup(id);
  }

  Future<Group> createGroup(String name){
    return networkMethod.createGroup(name);
  }

  Future<GroupOfPeople> addGroupOfPeople(int groupId, int personId){
    return networkMethod.addGroupOfPeople(groupId, personId);
  }

  Future<List<ActivityAndGroupsOfPeople>> PostActivityAndGroupsOfPeople(int activityId, int groupId){
    return networkMethod.PostActivityAndGroupsOfPeople(activityId, groupId);
  }

  Future<List<ActivityStatus>> getActivityStatusByActivity(int activityId){
    return networkMethod.getActivityStatusByActivity(activityId);
  }

  Future<Status> getStatusById(int id) {
    return networkMethod.getStatusById(id);
  }

  Future<Person> getPersonById (int id){
    return networkMethod.getPersonById(id);
  }

  Future<List<GroupOfPeople>> getByGroupId(int groupId){
    return networkMethod.getByGroupId(groupId);
  }

  Future<ActivityStatus> postPersonToActivity(int activityId, int personId){
    return networkMethod.postPersonToActivity(activityId, personId);
  }

}
