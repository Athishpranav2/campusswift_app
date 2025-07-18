import 'package:flutter/material.dart';
// If you have google_fonts in pubspec.yaml, keep this import. Otherwise, comment it out.
import 'package:google_fonts/google_fonts.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.22,
          height: screenWidth * 0.22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF4444).withOpacity(0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.11),
            child: Container(
              color: const Color(0xFF1C1C1C),
              // If the asset is missing, show a placeholder icon
              child: Image.asset(
                'assets/logo.jpeg',
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 48, color: Colors.white24),
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        // Use GoogleFonts if available, otherwise fallback to default
        Text(
          'SIDEKICK',
          style: (Theme.of(context).textTheme.titleLarge ?? const TextStyle()).copyWith(
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
            letterSpacing: 3,
            // Uncomment if google_fonts is available:
            // fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Text(
          'Your campus companion',
          style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8A8A8A),
            letterSpacing: 0.5,
            // Uncomment if google_fonts is available:
            // fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ],
    );
  }
}
