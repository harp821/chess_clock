import 'package:flutter/material.dart';
import 'models/chess_clock.dart';
import 'screen/timer_screen.dart';

void main() => runApp(const ChessClockApp());

class ChessClockApp extends StatelessWidget {
  const ChessClockApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF171412),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFB68442),
        brightness: Brightness.dark,
      ),
    ),
    home: TimerScreen(clock: ChessClock()),
  );
}
