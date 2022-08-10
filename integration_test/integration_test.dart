import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_bug/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('bug demonstration test', () {
    testWidgets('confirm slider is there, but with hit test + Cupertino, fails',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          // Verify the counter starts at 0.
          expect(find.text('Slider 1'), findsOneWidget);
          expect(find.byKey(const Key('Slider 1')), findsOneWidget);
          expect(find.text('Slider 2'), findsOneWidget);
          expect(find.byKey(const Key('Slider 2')), findsOneWidget);
          expect(find.text('Slider 3'), findsOneWidget);
          expect(find.byKey(const Key('Slider 3')), findsOneWidget);

          tester.printToConsole('If iOS/Cupertino sliders, this doesn\'t find '
              'the sliders (unless their initial value is 5, in the center...');

          Finder slidersFinder = find.byType(Slider).hitTestable();
          expect(slidersFinder, findsNWidgets(3));
        });
  });
}
