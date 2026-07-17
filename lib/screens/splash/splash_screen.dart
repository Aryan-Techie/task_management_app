// first screen the user sees — just shows the app name for a couple seconds
// then automatically redirects to the home screen
// using StatefulWidget because initState is needed for the delayed navigation

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // wait for splashDuration seconds then go to home
    // checking mounted first to avoid navigating on a widget that's already been removed
    Future.delayed(
      const Duration(seconds: AppConstants.splashDuration),
      () {
        if (!mounted) return;
        context.go('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Task Management App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
