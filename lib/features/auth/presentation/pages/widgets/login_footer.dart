import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFooter extends StatelessWidget {
  final VoidCallback onTermsPressed;
  final VoidCallback onPrivacyPolicyPressed;

  const LoginFooter({
    super.key,
    required this.onTermsPressed,
    required this.onPrivacyPolicyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          'By continuing, you agree to our',
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.03,
            color: const Color(0xFF8A8A8A).withOpacity(0.8),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onTermsPressed,
              child: Text(
                'Terms of Service',
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.03,
                  color: const Color(0xFFFF4444),
                ),
              ),
            ),
            Text(
              ' and ',
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.03,
                color: const Color(0xFF8A8A8A).withOpacity(0.8),
              ),
            ),
            TextButton(
              onPressed: onPrivacyPolicyPressed,
              child: Text(
                'Privacy Policy',
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.03,
                  color: const Color(0xFFFF4444),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
