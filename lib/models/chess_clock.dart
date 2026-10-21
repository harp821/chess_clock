import 'dart:async';
import 'package:flutter/foundation.dart';

enum Player { none, top, bottom }

class ChessClock extends ChangeNotifier {
  ChessClock() {
    reset();
  }
  Duration initial = const Duration(minutes: 2),
      increment = Duration.zero,
      topTime = Duration.zero,
      bottomTime = Duration.zero;
  int topMoves = 0, bottomMoves = 0;
  Player active = Player.none;
  bool paused = false, sound = true;
  Timer? _ticker;
  DateTime _last = DateTime.now();

  bool get isRunning => _ticker != null;
  bool get flagged => topTime == Duration.zero || bottomTime == Duration.zero;
  bool tap(Player p) {
    if (paused || flagged || (active != Player.none && active != p))
      return false;
    final started = active != Player.none;
    if (started) {
      _drain();
      if (flagged) {
        _stop();
        return false;
      }
    }
    if (p == Player.top) {
      topMoves++;
      if (started) topTime += increment;
    } else {
      bottomMoves++;
      if (started) bottomTime += increment;
    }
    active = p == Player.top ? Player.bottom : Player.top;
    _start();
    return true;
  }

  void togglePause() {
    if (active == Player.none || flagged) return;
    (paused = !paused) ? _stop() : _start();
  }

  void toggleSound() {
    sound = !sound;
    notifyListeners();
  }

  void reset({Duration? to, Duration? inc}) {
    _stop();
    initial = to ?? initial;
    increment = inc ?? increment;
    topTime = bottomTime = initial;
    topMoves = bottomMoves = 0;
    active = Player.none;
    paused = false;
    notifyListeners();
  }

  void _start() {
    _ticker?.cancel();
    _last = DateTime.now();
    _ticker = Timer.periodic(const Duration(milliseconds: 50), (_) => _tick());
    notifyListeners();
  }

  void _stop() {
    _ticker?.cancel();
    _ticker = null;
    notifyListeners();
  }

  /// Subtracts real elapsed time from the active player so the clock never drifts.
  void _drain() {
    final now = DateTime.now(), elapsed = now.difference(_last);
    _last = now;
    Duration dec(Duration d) =>
        d - elapsed < Duration.zero ? Duration.zero : d - elapsed;
    active == Player.top
        ? (topTime = dec(topTime))
        : (bottomTime = dec(bottomTime));
  }

  void _tick() {
    _drain();
    flagged ? _stop() : notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
