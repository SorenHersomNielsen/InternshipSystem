import 'package:mockito/mockito.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internship/Model/Person.dart';
import 'NetworkMethod_test.mocks.dart';
import 'package:internship/EncryptData.dart';
import 'package:internship/Model/Activty.dart';
import 'package:internship/Model/Group.dart';
import 'package:internship/Model/ActivityStatus.dart';

@GenerateMocks([http.Client])
void main(){
    group('testing network method', () {
      final client = MockClient();
      final network = NetworkMethod();

      test('testing fetch person', () async{
     when(client.get(
       Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=søren@test.dk&passWord=1235')
     )).thenAnswer((_) async =>
     http.Response('{"id": 3,"name": "Søren","mail": "søren@test.dk","password": "1235","telephoneNumber": "11223344","internship": "Beck IT","school": "Zealand","role": "Admin"}', 200
            ));
     expect(await network.fetchPerson("søren@test.dk", "1235"), isA<Person>());
      });

      test('testing fetch person fall',() async{
        when(client.get(
            Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=søren@test.dk&passWord=1236')
        )).thenAnswer((_) async =>
        http.Response('Der findes ikke en bruger med email: søren@test.dk og med det kodeord', 404));

        expect(await network.fetchPerson("søren@test.dk", "1236"), null);

      });

      test('testing get person data', () async{
        EncryptData.encryptAES("1235");
        when(client.get(
      Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=søren@test.dk&passWord=1235'))).thenAnswer((_) async =>
        http.Response('{"id": 3,"name": "Søren","mail": "søren@test.dk","password": "1235","telephoneNumber": "11223344","internship": "Beck IT","school": "Zealand","role": "Admin"}', 200));

        expect(await network.getPersonData("søren@test.dk", "1235"),isA<Person>());
      });

      test('testing get activity data',() async {

        when(client.get(
            Uri.parse('http://localhost:5000/api/Activities'))).thenAnswer((_) async =>
            http.Response('{"id": 1,"headline": "Møde","date": "2022-05-20T12:00:00"},{"id": 2,"headline": "Møde","date": "2022-05-23T14:00:00"},{"id": 3,"headline": "test","date": "2022-05-24T12:00:00"},{"id": 4,"headline": "test","date": "2021-12-24T12:00:00"},{"id": 5,"headline": "string","date": "2022-05-24T11:37:40.123"},{"id": 6,"headline": "test","date": "2025-07-09T13:35:00"},{"id": 7"headline": "test","date": "2021-07-14T13:30:00"},{"id": 8,"headline": "test","date": "2021-07-05T14:35:00"},{"id": 9,"headline": "test 2","date": "2022-09-05T11:30:00"},{"id": 10,"headline": "test","date": "2022-05-25T08:30:00"},{"id": 1003,"headline": "møde","date": "2022-05-29T12:30:00"},{"id": 1004,"headline": "møde","date": "2022-05-29T14:35:00"},{"id": 1005,"headline": "unik","date": "2022-05-31T14:35:00"},{"id": 1006,"headline": "unik 1","date": "2022-05-30T14:35:00"},{"id": 1007,"headline": "unik 2","date": "2022-05-29T13:35:00"},{"id": 1008,"headline": "asfdsfd","date": "2022-05-29T14:35:00"},{"id": 1009,"headline": "dasdsadad","date": "2022-05-29T14:35:00"},{"id": 1010,"headline": "asdasd","date": "2022-05-29T14:35:00"},{"id": 1011,"headline": "afdghyjgm","date": "2022-05-31T14:35:00"},{"id": 1012,"headline": "John og Sørens aflevering","date": "2022-06-07T12:00:00"},{"id": 1013,"headline": "aflevering","date": "2022-06-07T12:00:00"},{"id": 1014,"headline": "møde","date": "2022-05-31T12:30:00"},{"id": 1015,"headline": "møde","date": "2022-05-30T13:12:00"},{"id": 1016,"headline": "møde","date": "2022-05-30T12:20:00"},{"id": 1017,"headline": "aerfresf","date": "2022-05-30T12:30:00"},"id": 1018,"headline": "sefdgdfg","date": "2022-05-30T12:30:00"},{"id": 1019,"headline": "sadfaf ","date": "2022-05-30T12:30:00"},{"id": 1020,"headline": "Møde","date": "2022-05-30T13:29:00"},{"id": 1021,"headline": "test","date": "2022-06-04T10:21:00"}'
            , 200));

        expect(await network.getActivityData("admin",3),isA<List<Activity>>());
      });

      test('get all group', () async {
        when(client.get(
          Uri.parse(
              'http://localhost:5000/api/Groups'
          ))).thenAnswer((_) async =>
        http.Response(
        '{"id": 1,"name": "test"},{"id": 9,"name": "test},{"id": 38,"name": "test"},{"id": 39,"name": "test"},{"id": 40,"name": "test"},{"id": 46,"name": "Søren og john"}'
        , 200));

        expect(await network.getAllGroups(), isA<List<Group>>());
      });

      test('change password', () async {
        when(client.put(Uri.parse(
            'http://localhost:5000/api/Persons/PutPath?email=søren@test.dk&oldPassWord=1235&newPassWord=1234'
        ))).thenAnswer((_) async =>
        http.Response(
          '{"id": 3,"name": "Søren","mail": "søren@test.dk","password": "1235","telephoneNumber": "11223344","internship": "Beck IT","school": "Zealand","role": "Admin"}'
              ,200));
        expect(network.changePassword('søren@test.dk','1234','1235'), isA<Future<String>>());
      });
      test('post person to activity fail', () async {
        when(client.post(Uri.parse(
            'http://localhost:5000/api/ActivityStatuses?activityId=6&personId=3'
        ))).thenAnswer((_) async =>
        http.Response(
          '{"id": 1008,"activityId": 6,"statusId": 3}', 201));

        expect(network.postPersonToActivity(6,3), isA<Future<ActivityStatus>>());
      });
    });
  }