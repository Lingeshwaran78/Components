import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Components', () {
    test('validString should return empty string for null input', () {
      expect(Components.validString(null), '');
    });

    test('validString should return trimmed string for non-empty input', () {
      expect(Components.validString('  test  '), 'test');
    });

    test('isNullOrEmptyList should return true for null input', () {
      expect(Components.isNullOrEmptyList(null), true);
    });

    test('isNullOrEmptyList should return true for empty list', () {
      expect(Components.isNullOrEmptyList([]), true);
    });

    test('isNullOrEmptyList should return false for non-empty list', () {
      expect(Components.isNullOrEmptyList([1, 2, 3]), false);
    });

    test('isNullOrEmptyString should return true for null input', () {
      expect(Components.isNullOrEmptyString(null), true);
    });

    test('isNullOrEmptyString should return true for empty string', () {
      expect(Components.isNullOrEmptyString(''), true);
    });

    test('isNullOrEmptyString should return true for string with only spaces',
        () {
      expect(Components.isNullOrEmptyString('   '), true);
    });

    test('isNullOrEmptyString should return false for non-empty string', () {
      expect(Components.isNullOrEmptyString('test'), false);
    });

    testWidgets('ShrinkingButton should shrink on tap',
        (WidgetTester tester) async {
      bool buttonTapped = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ShrinkingButton(
            text: 'Tap me',
            onTap: () {
              buttonTapped = true;
            },
          ),
        ),
      ));

      final Finder buttonFinder = find.text('Tap me');
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(buttonTapped, true);
    });
  });
}
