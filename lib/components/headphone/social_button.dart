import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/headphone_colors.dart';

/// Rounded square brand button: a coloured tile inside a white frame.
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.color,
    this.background,
    this.iconSize = 28,
  });

  final FaIconData icon;
  final String tooltip;
  final VoidCallback onTap;

  /// Solid tile colour. Ignored when [background] is given.
  final Color? color;

  /// Custom tile fill, such as a CornerBlend.
  final Widget? background;
  final double iconSize;

  static const size = 56.0;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: HeadphoneColors.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  background ?? ColoredBox(color: color!),
                  Center(
                    child: FaIcon(icon, size: iconSize, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
