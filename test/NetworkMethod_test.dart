import 'package:mockito/mockito.dart';
import 'package:internship/NetworkMethod.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internship/Model/Person.dart';
import 'NetworkMethod_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
    group('testing network method', () {
      test('testing fetch person', () async{
        final client = MockClient();
        final network = NetworkMethod();

     when(client.get(
       Uri.parse('http://localhost:5000/api/Persons/OnePerson?mail=Søren@test&passWord=1235')
     )).thenAnswer((_) async =>
     http.Response('{"id": 3,"name": "Søren","mail": "søren@test.dk","password": "1235","telephoneNumber": "11223344","internship": "Beck IT","school": "Zealand","role": "Admin"}', 200
            ));
     expect(await network.fetchPerson("søren@test.dk", "1235"), isA<Person>());
      });



    });
  }