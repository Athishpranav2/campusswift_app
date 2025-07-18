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
      mainAxisSize: MainAxisSize.min, // This helps reduce overall spacing
      children: [
        Text(
          'By continuing, you agree to our',
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.03,
            color: const Color(0xFF8A8A8A).withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 2), // Add minimal spacing between text and row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onTermsPressed,
              style: TextButton.styleFrom(
                minimumSize: Size.zero, // Remove minimum size
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ), // Reduce padding
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Reduce tap target
              ),
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
              style: TextButton.styleFrom(
                minimumSize: Size.zero, // Remove minimum size
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ), // Reduce padding
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Reduce tap target
              ),
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
