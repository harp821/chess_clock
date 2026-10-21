import 'package:flutter/material.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({
    super.key,
    required this.running,
    required this.sound,
    required this.onReset,
    required this.onPause,
    required this.onTime,
    required this.onSound,
  });
  final bool running, sound;
  final VoidCallback onReset, onPause, onTime, onSound;

  @override
  Widget build(BuildContext context) => Container(
    height: 64,
    color: const Color(0xFF1C1C1E),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _button(Icons.refresh_rounded, onReset),
        _button(
          running ? Icons.pause_rounded : Icons.play_arrow_rounded,
          onPause,
        ),
        _button(Icons.timer_outlined, onTime),
        _button(
          sound ? Icons.volume_up_rounded : Icons.volume_off_rounded,
          onSound,
        ),
      ],
    ),
  );

  Widget _button(IconData i, VoidCallback f) => IconButton(
    onPressed: f,
    icon: Icon(i, color: Colors.white, size: 28),
  );
}
