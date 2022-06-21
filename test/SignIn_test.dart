import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internship/Widget/Signin.dart';

void main() {
  
   testWidgets("find title", (widgetTester) async {
     await widgetTester.pumpWidget(MaterialApp(home: SignIn()));

    final title = find.text('Log på');

    expect(title, findsWidgets);
   });

   group('testing sign in function', () {
      testWidgets('username', (widgetTester) async{
        const testkey = Key('email');
        await widgetTester.pumpWidget(MaterialApp(key: testkey,home: SignIn()));

      expect(find.byKey(testkey),findsWidgets);

      });

      testWidgets('password', (widgetTester) async{

        const testKey = Key('password');

        await widgetTester.pumpWidget(MaterialApp(key: testKey,home: SignIn()));

        expect(find.byKey(testKey),findsWidgets);

      });


      testWidgets('Sign in button', (widgetTester) async {
        const emailKey = Key('email');
        const passwordKey = Key('password');
        const buttonKey = Key('button');

        await widgetTester.pumpWidget(MaterialApp(home: SignIn()));


        await widgetTester.enterText(find.byKey(emailKey), 'søren@test.dk');

        await widgetTester.enterText(find.byKey(passwordKey), '1235');

        await widgetTester.tap(find.byKey(buttonKey));

        await widgetTester.pump(Duration(milliseconds: 400));

      });
   });

}