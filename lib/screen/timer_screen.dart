import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/chess_clock.dart';
import '../widgets/control_bar.dart';
import '../widgets/player_panel.dart';
import '../widgets/time_picker_sheet.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key, required this.clock});
  final ChessClock clock;

  void _onTap(Player p) {
    if (!clock.tap(p)) return;
    if (clock.sound) SystemSound.play(SystemSoundType.click);
    HapticFeedback.lightImpact();
  }

  Widget _panel(Player p) {
    final top = p == Player.top;
    return PlayerPanel(
      time: top ? clock.topTime : clock.bottomTime,
      moves: top ? clock.topMoves : clock.bottomMoves,
      increment: clock.increment,
      active: clock.active == p,
      flipped: top,
      onTap: () => _onTap(p),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: ListenableBuilder(
        listenable: clock,
        builder: (context, _) => Column(
          children: [
            _panel(Player.top),
            ControlBar(
              running: clock.isRunning,
              sound: clock.sound,
              onReset: clock.reset,
              onPause: clock.togglePause,
              onSound: clock.toggleSound,
              onTime: () => showTimePickerSheet(
                context,
                clock.initial,
                clock.increment,
                (t, i) => clock.reset(to: t, inc: i),
              ),
            ),
            _panel(Player.bottom),
          ],
        ),
      ),
    ),
  );
}
