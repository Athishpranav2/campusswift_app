import 'package:flutter/material.dart';
import 'core/routes/app_router.dart'; // Import your router configuration
// import 'core/theme/app_theme.dart'; // Optional: Import your custom theme

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MaterialApp.router for a scalable, navigation-driven app
    return MaterialApp.router(
      // --- Routing Configuration ---
      // Connects the app to your router defined in app_router.dart
      routerConfig: AppRouter.router,

      // --- General App Configuration ---
      title: 'Sidekick',
      debugShowCheckedModeBanner: false, // Hides the debug banner in the corner
      // --- Theming ---
      // You can define your app's look and feel here or in a separate theme file.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // darkTheme: AppTheme.darkTheme, // Optional: for dark mode support
    );
  }
}
