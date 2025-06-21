// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Update the import path below to match the actual location of your main.dart file.
// For example, if main.dart is in lib/, use:
// Update the import path below to match the actual location of your SimpleLinkPage class.
// Make sure the import path matches the actual location of your SimpleLinkPage class.
// For example, if SimpleLinkPage is defined in lib/pages/simple_link_page.dart, use:
// TODO: Update the import path below to the correct location of SimpleLinkPage.
// For example, if SimpleLinkPage is in lib/simple_link_page.dart, use:
import 'package:futuristic_portfolio/simple_link_page.dart';
// If the file does not exist, create it and define the SimpleLinkPage widget.

void main() {
  testWidgets('FuturisticPortfolioPage has profile name', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: FuturisticPortfolioPage()));

    // Verify that the profile name is displayed.
    expect(find.text('Sulman Farooq'), findsOneWidget);
  });
}
