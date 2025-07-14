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
        title: 'Wittly - Conversation Master',
        theme: AppTheme.darkTheme,
        home: const OnboardingScreen(),
        debugShowCheckedModeBanner: false,
        // Add custom route transitions
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) {
              switch (settings.name) {
                case '/main':
                  return const MainScreen();
                case '/onboarding':
                  return const OnboardingScreen();
                default:
                  return const OnboardingScreen();
              }
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}
