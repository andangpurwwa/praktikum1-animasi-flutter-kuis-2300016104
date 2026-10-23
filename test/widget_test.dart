import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/main.dart';

void main() {
  testWidgets('App renders HomeScreen with New Game button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Verify that the home screen elements are present.
    expect(find.text('Flutter Quiz'), findsOneWidget);
    expect(find.text('New Game'), findsOneWidget);
  });
}
