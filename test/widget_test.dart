import 'package:flutter_test/flutter_test.dart';

import 'package:chess_clock/main.dart';
import 'package:chess_clock/screen/timer_screen.dart';

void main() {
  testWidgets('Chess clock app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ChessClockApp());

    expect(find.byType(TimerScreen), findsOneWidget);
  });
}
