import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/headphone_colors.dart';

/// White pill field: leading icon, a thin divider, then the text.
class WhiteField extends StatelessWidget {
  const WhiteField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hint,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  static const height = 58.0;

  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24)),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Soft shadow sits behind the pill only, not the error text below it.
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: _border.borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: HeadphoneColors.shadow,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          cursorColor: const Color(0xFF3D5AFE),
          style: GoogleFonts.quicksand(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: HeadphoneColors.ink,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.quicksand(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: HeadphoneColors.hint,
            ),
            errorStyle: GoogleFonts.quicksand(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: HeadphoneColors.error,
            ),
            prefixIcon: SizedBox(
              width: 72,
              height: 26,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Icon(icon, size: 22, color: HeadphoneColors.ink),
                  const Spacer(),
                  Container(
                    width: 1,
                    height: 26,
                    color: HeadphoneColors.divider,
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 72),
            suffixIcon: suffix,
            suffixIconColor: HeadphoneColors.ink,
            filled: true,
            fillColor: HeadphoneColors.field,
            contentPadding: const EdgeInsets.fromLTRB(0, 19, 20, 19),
            border: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            errorBorder: _border,
            focusedErrorBorder: _border,
          ),
        ),
      ],
    );
  }
}

/// [WhiteField] with a lock icon and an eye button that shows / hides the
/// password.
class WhitePasswordField extends StatefulWidget {
  const WhitePasswordField({
    super.key,
    required this.controller,
    this.hint = 'Password',
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<WhitePasswordField> createState() => _WhitePasswordFieldState();
}

class _WhitePasswordFieldState extends State<WhitePasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return WhiteField(
      controller: widget.controller,
      icon: Icons.lock_rounded,
      hint: widget.hint,
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      onSubmitted: widget.onSubmitted,
      validator: widget.validator,
      suffix: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          tooltip: _obscure ? 'Show password' : 'Hide password',
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            size: 22,
          ),
        ),
      ),
    );
  }
}
