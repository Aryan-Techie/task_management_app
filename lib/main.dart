// this is where the app starts
// ProviderScope wraps everything so Riverpod can work throughout the app
// without this, ref.watch and ref.read won't work anywhere

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() {
  runApp(
    // ProviderScope is required by Riverpod — it's like the root container for all providers
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // using .router instead of regular MaterialApp because GoRouter needs it
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false, // hides the red DEBUG banner
    );
  }
}