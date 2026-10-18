import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Four-corner colour blend, e.g. the Instagram logo background.
///
/// Built from a small bitmap that is stretched to fit, not a gradient
/// shader, for the same reason as TopGlow: Flutter's iOS renderer dithers
/// gradients into visible dots.
class CornerBlend extends StatefulWidget {
  const CornerBlend({
    super.key,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  final Color topLeft;
  final Color topRight;
  final Color bottomLeft;
  final Color bottomRight;

  @override
  State<CornerBlend> createState() => _CornerBlendState();
}

class _CornerBlendState extends State<CornerBlend> {
  static const _size = 32;

  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _build();
  }

  @override
  void didUpdateWidget(CornerBlend oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.topLeft != widget.topLeft ||
        oldWidget.topRight != widget.topRight ||
        oldWidget.bottomLeft != widget.bottomLeft ||
        oldWidget.bottomRight != widget.bottomRight) {
      _build();
    }
  }

  void _build() {
    final pixels = Uint8List(_size * _size * 4);
    for (var y = 0; y < _size; y++) {
      final v = y / (_size - 1);
      final left = Color.lerp(widget.topLeft, widget.bottomLeft, v)!;
      final right = Color.lerp(widget.topRight, widget.bottomRight, v)!;
      for (var x = 0; x < _size; x++) {
        final c = Color.lerp(left, right, x / (_size - 1))!;
        final i = (y * _size + x) * 4;
        pixels[i] = (c.r * 255).round();
        pixels[i + 1] = (c.g * 255).round();
        pixels[i + 2] = (c.b * 255).round();
        pixels[i + 3] = 255;
      }
    }
    ui.decodeImageFromPixels(pixels, _size, _size, ui.PixelFormat.rgba8888, (
      image,
    ) {
      if (!mounted) {
        image.dispose();
        return;
      }
      setState(() {
        _image?.dispose();
        _image = image;
      });
    });
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    if (image == null) return ColoredBox(color: widget.bottomRight);
    return RawImage(
      image: image,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.low,
    );
  }
}
