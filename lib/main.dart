import 'package:flutter/material.dart';
import 'package:islami_app/cache/cache_helper.dart';

import 'home_screen.dart';
import 'onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CacheHelper.getEligibility() == true
          ? HomeScreen.routeName
          : OnboardingScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
