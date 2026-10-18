import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/headphone/headphone_components.dart';
import '../theme/headphone_colors.dart';
import '../utils/validators.dart';

class HeadphoneLoginScreen extends StatefulWidget {
  const HeadphoneLoginScreen({super.key});

  @override
  State<HeadphoneLoginScreen> createState() => _HeadphoneLoginScreenState();
}

class _HeadphoneLoginScreenState extends State<HeadphoneLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _showMessage('Logged in as ${_emailController.text.trim()}');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: HeadphoneColors.background,
        body: Stack(
          children: [
           
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: _buildContent(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 3),
          const Icon(
            Icons.headphones_rounded,
            size: 128,
            color: HeadphoneColors.ink,
          ),
          const SizedBox(height: 28),
          Text(
            'Headphone',
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: HeadphoneColors.ink,
            ),
          ),
          const SizedBox(height: 40),
          AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WhiteField(
                  controller: _emailController,
                  icon: Icons.email_rounded,
                  hint: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: Validators.email,
                ),
                const SizedBox(height: 18),
                WhitePasswordField(
                  controller: _passwordController,
                  onSubmitted: (_) => _submit(),
                  validator: Validators.password,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: _TextLink(
              'Forgot Password?',
              onTap: () => _showMessage('Password reset coming soon'),
            ),
          ),
          const SizedBox(height: 26),
          _LoginButton(onTap: _submit),
          const SizedBox(height: 34),
          _buildDividerLabel(),
          const SizedBox(height: 22),
          _buildSocialRow(),
          const Spacer(flex: 2),
          _buildSignUpRow(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDividerLabel() {
    const line = Expanded(
      child: Divider(color: HeadphoneColors.line, thickness: 1),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or continue with',
            style: GoogleFonts.quicksand(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: HeadphoneColors.muted,
            ),
          ),
        ),
        line,
      ],
    );
  }

  Widget _buildSocialRow() {
    void soon(String name) => _showMessage('$name login coming soon');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 14,
      children: [
        SocialButton(
          icon: FontAwesomeIcons.facebookF,
          tooltip: 'Facebook',
          color: HeadphoneColors.facebook,
          onTap: () => soon('Facebook'),
        ),
        SocialButton(
          icon: FontAwesomeIcons.twitter,
          tooltip: 'Twitter',
          color: HeadphoneColors.twitter,
          onTap: () => soon('Twitter'),
        ),
        SocialButton(
          icon: FontAwesomeIcons.instagram,
          tooltip: 'Instagram',
          background: const CornerBlend(
            topLeft: HeadphoneColors.instaTopLeft,
            topRight: HeadphoneColors.instaTopRight,
            bottomLeft: HeadphoneColors.instaBottomLeft,
            bottomRight: HeadphoneColors.instaBottomRight,
          ),
          onTap: () => soon('Instagram'),
        ),
        SocialButton(
          icon: FontAwesomeIcons.play,
          tooltip: 'YouTube',
          color: HeadphoneColors.youtube,
          iconSize: 20,
          onTap: () => soon('YouTube'),
        ),
      ],
    );
  }

  Widget _buildSignUpRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: HeadphoneColors.muted,
          ),
        ),
        _TextLink(
          'Sign Up',
          fontSize: 16,
          onTap: () => _showMessage('Sign up coming soon'),
        ),
      ],
    );
  }
}

class _TextLink extends StatelessWidget {
  const _TextLink(this.label, {required this.onTap, this.fontSize = 15});

  final String label;
  final VoidCallback onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: HeadphoneColors.ink,
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: HeadphoneColors.ink,
            borderRadius: BorderRadius.circular(29),
          ),
          child: Text(
            'Login',
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
