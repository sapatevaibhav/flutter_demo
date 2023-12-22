// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/app/app.dart';

void main() {
  testWidgets('Calculater test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    expect(find.byIcon(CupertinoIcons.add), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.minus), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.divide), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.multiply), findsOneWidget);

    // Advanced test case for the calculator
    await tester.enterText(find.byKey(const Key("displayOne")), "20"); // Insert the value to the textfield one
    await tester.enterText(find.byKey(const Key("displayTwo")), "30"); // Insert the value to the textfield two
    await tester.tap(find.byIcon(CupertinoIcons.add)); // Clicked on the addition symboled button +

    await tester.pump(); // Rebuild the app

    expect(find.text("50"), findsOneWidget); // Find the actual result
  });
}
