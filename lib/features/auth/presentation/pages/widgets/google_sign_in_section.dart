import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInSection extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleSignInSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          'Welcome Mate',
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          'Sign in to continue',
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8A8A8A),
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF4444).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4444),
              foregroundColor: const Color(0xFFFFFFFF),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.08,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SvgPicture.asset(
                    'assets/google_logo.svg',
                    height: screenWidth * 0.05,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  'Continue with Google',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.01,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF8A8A8A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF8A8A8A).withOpacity(0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: screenWidth * 0.04,
                color: const Color(0xFF8A8A8A),
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                'Only @psgtech.ac.in emails allowed',
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.032,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8A8A8A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
