import 'package:flutter/material.dart';

import 'screens/headphone_login_screen.dart';
import 'theme/headphone_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Headphone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: HeadphoneColors.background,
        ),
        scaffoldBackgroundColor: HeadphoneColors.background,
        // No Material ripple, highlight or hover anywhere in the app.
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const HeadphoneLoginScreen(),
    );
  }
}
