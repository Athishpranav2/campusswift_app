import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
// Import other screens as you create them
// import '../../features/home/presentation/pages/home_screen.dart';

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  // The router configuration.
  static final router = GoRouter(
    // The initial location of the app
    initialLocation: '/login',

    // The list of routes
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      // Example of another route:
      // GoRoute(
      //   path: '/home',
      //   builder: (context, state) => const HomeScreen(),
      // ),
    ],
  );
}
