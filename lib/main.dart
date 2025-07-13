import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'core/app_state.dart';
import 'screens/main_screen.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const WittlyApp());
}

class WittlyApp extends StatelessWidget {
  const WittlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Wittly',
        theme: AppTheme.darkTheme,
        home: const OnboardingScreen(), // Start with onboarding
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
