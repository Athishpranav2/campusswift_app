import 'package:flutter/material.dart';
import '../widgets/google_sign_in_section.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_header.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header at the top
              SizedBox(height: screenHeight * 0.12), // ~12% of screen height
              const LoginHeader(),
              const Spacer(),

              // Bottom Section (Google Button + Footer)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const GoogleSignInSection(),
                  SizedBox(height: screenHeight * 0.04), // ~4% spacing
                  LoginFooter(
                    onTermsPressed: () {
                      debugPrint('Terms of Service tapped');
                    },
                    onPrivacyPolicyPressed: () {
                      debugPrint('Privacy Policy tapped');
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03), // ~3% bottom spacing
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
