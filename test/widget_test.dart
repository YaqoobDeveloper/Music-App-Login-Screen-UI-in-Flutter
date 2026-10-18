import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:login_screen/app.dart';

void main() {
  setUp(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const App());
  }

  testWidgets('Login with empty fields shows validation errors', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Valid login shows a confirmation', (tester) async {
    await pumpApp(tester);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'khalil@gmail.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Logged in as khalil@gmail.com'), findsOneWidget);
  });

  testWidgets('Eye icon toggles password visibility', (tester) async {
    await pumpApp(tester);

    EditableText password() =>
        tester.widget<EditableText>(find.byType(EditableText).at(1));
    expect(password().obscureText, isTrue);
    await tester.tap(find.byIcon(Icons.visibility_off_rounded));
    await tester.pump();
    expect(password().obscureText, isFalse);
  });

  testWidgets('Social buttons show a coming soon message', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Instagram'));
    await tester.pump();
    expect(find.text('Instagram login coming soon'), findsOneWidget);
  });
}
