import 'package:flutter/material.dart';

const _minutePresets = [1, 2, 3, 5, 10, 15, 30];
const _incrementPresets = [0, 1, 2, 3, 5, 10];
const _green = Color(0xFF43A047);
const _title = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

Future<void> showTimePickerSheet(
  BuildContext context,
  Duration time,
  Duration increment,
  void Function(Duration time, Duration increment) onPick,
) {
  var mins = time.inMinutes, inc = increment.inSeconds;
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1C1C1E),
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setSheet) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Time per player', style: _title),
              const SizedBox(height: 16),
              _chips(
                _minutePresets,
                mins,
                (v) => '$v min',
                (v) => setSheet(() => mins = v),
              ),
              const SizedBox(height: 24),
              const Text('Increment per move', style: _title),
              const SizedBox(height: 16),
              _chips(
                _incrementPresets,
                inc,
                (v) => v == 0 ? 'None' : '+$v sec',
                (v) => setSheet(() => inc = v),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    onPick(Duration(minutes: mins), Duration(seconds: inc));
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    'Set $mins+$inc',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _chips(
  List<int> values,
  int selected,
  String Function(int) label,
  ValueChanged<int> onTap,
) => Wrap(
  spacing: 10,
  runSpacing: 10,
  children: [
    for (final v in values)
      ChoiceChip(
        label: Text(label(v)),
        selected: selected == v,
        selectedColor: _green,
        onSelected: (_) => onTap(v),
      ),
  ],
);
