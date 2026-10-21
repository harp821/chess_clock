import 'package:flutter/material.dart';

class PlayerPanel extends StatelessWidget {
  const PlayerPanel({
    super.key,
    required this.time,
    required this.moves,
    required this.active,
    required this.onTap,
    this.increment = Duration.zero,
    this.flipped = false,
  });
  final Duration time, increment;
  final int moves;
  final bool active, flipped;
  final VoidCallback onTap;

  bool get _flagged => time == Duration.zero;
  String get _label {
    final m = time.inMinutes.toString().padLeft(2, '0');
    final s = (time.inSeconds % 60).toString().padLeft(2, '0');
    if (time.inSeconds < 10 && !_flagged)
      return '$s.${time.inMilliseconds % 1000 ~/ 100}';
    return '$m:$s';
  }

  String get _subtitle {
    if (_flagged) return "Time's up!";
    return increment > Duration.zero
        ? 'Moves: $moves   +${increment.inSeconds}s'
        : 'Moves: $moves';
  }

  List<Color> get _colors => _flagged
      ? const [Color(0xFFC62828), Color(0xFFFF5252)]
      : active
      ? const [Color(0xFF43A047), Color(0xFFB2FF59)]
      : const [Color(0xFF5F5F5F), Color(0xFF9A9A9A)];

  @override
  Widget build(BuildContext context) => Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _colors,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: RotatedBox(
          quarterTurns: flipped ? 2 : 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _label,
                      style: const TextStyle(
                        fontSize: 88,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontFeatures: [FontFeature.tabularFigures()],
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _subtitle,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
