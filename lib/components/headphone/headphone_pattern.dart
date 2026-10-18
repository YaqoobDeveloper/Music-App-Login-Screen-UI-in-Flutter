import 'package:flutter/material.dart';

/// Faint headphone icons tiled across the screen, every other column
/// nudged down a little.
class HeadphonePattern extends StatelessWidget {
  const HeadphonePattern({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _PatternPainter(color), size: Size.infinite);
  }
}

class _PatternPainter extends CustomPainter {
  _PatternPainter(this.color);

  final Color color;

  static const _iconSize = 26.0;
  static const _dx = 67.0;
  static const _dy = 72.0;
  static const _stagger = 11.0;

  @override
  void paint(Canvas canvas, Size size) {
    const icon = Icons.headphones_rounded;
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: _iconSize,
          color: color,
        ),
      ),
    )..layout();

    for (var col = 0; col * _dx < size.width + _dx; col++) {
      final x = 20 + col * _dx;
      final offsetY = col.isOdd ? _stagger : 0;
      for (var row = 0; row * _dy < size.height + _dy; row++) {
        painter.paint(canvas, Offset(x, 22 + row * _dy + offsetY));
      }
    }
    painter.dispose();
  }

  @override
  bool shouldRepaint(_PatternPainter oldDelegate) => oldDelegate.color != color;
}
