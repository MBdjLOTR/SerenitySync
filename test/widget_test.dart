
import 'package:flutter_test/flutter_test.dart';

import 'package:mind_soul_relaxation/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SoulRelaxationApp());

    // Verify that the HomeScreen title appears.
    expect(find.text('Mind & Soul Relaxation'), findsOneWidget);
  });
}

