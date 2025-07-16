import 'package:flutter/material.dart';
// Import your new widgets
import 'widgets/google_sign_in_section.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // Widget 1
              const LoginHeader(),

              const Spacer(flex: 2),

              // Widget 2
              GoogleSignInSection(
                onPressed: () {
                  // Your Google Sign-In logic goes here
                  debugPrint('Sign in with Google button tapped');
                },
              ),

              const Spacer(flex: 2),

              // Widget 3
              LoginFooter(
                onTermsPressed: () {
                  // Navigate to Terms of Service
                  debugPrint('Terms of Service tapped');
                },
                onPrivacyPolicyPressed: () {
                  // Navigate to Privacy Policy
                  debugPrint('Privacy Policy tapped');
                },
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
