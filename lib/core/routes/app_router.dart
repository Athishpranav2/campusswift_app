import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  // The router configuration with authentication-based navigation
  static final router = GoRouter(
    // The initial location will be determined by auth state
    initialLocation: '/login',

    // Redirect logic based on authentication state
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isLoggedIn = user != null;
      final isLoggingIn = state.matchedLocation == '/login';

      // If user is not logged in and not on login page, redirect to login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // If user is logged in and on login page, redirect to home
      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }

      // No redirect needed
      return null;
    },

    // The list of routes
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
