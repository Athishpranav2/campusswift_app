/// Security constants and configurations for the application
class SecurityConstants {
  // Rate limiting
  static const Duration minAuthInterval = Duration(seconds: 3);
  static const int maxFailedAttempts = 5;
  static const Duration failedAttemptLockoutDuration = Duration(minutes: 5);
  
  // Input validation
  static const int maxDisplayNameLength = 50;
  static const int maxEmailLength = 254; // RFC compliant
  
  // Token validation
  static const int jwtMinParts = 3;
  
  // Security patterns
  static final RegExp htmlSanitizationPattern = RegExp(r'[<>"\\\/]');
  static final RegExp specialCharacterPattern = RegExp(r"[']");
  
  // Google Sign-In scopes (minimum required)
  static const List<String> googleSignInScopes = [
    'email',
    'profile',
  ];
  
  // Session management
  static const Duration sessionTimeout = Duration(hours: 24);
  static const Duration refreshTokenBuffer = Duration(minutes: 30);
  
  // Logging categories
  static const String authSuccessLogName = 'AuthSuccess';
  static const String authErrorLogName = 'AuthError';
  static const String authSecurityLogName = 'AuthSecurity';
  static const String authInfoLogName = 'AuthInfo';
  
  // Error messages (user-facing, no system details)
  static const Map<String, String> userFriendlyErrorMessages = {
    'cancelled': 'Sign in cancelled by user',
    'invalid_account': 'Invalid account information',
    'invalid_credentials': 'Authentication failed. Invalid credentials.',
    'invalid_token': 'Authentication failed. Invalid access token.',
    'auth_failed': 'Authentication failed. Please try again.',
    'rate_limited': 'Too many attempts. Please wait before trying again.',
    'network_error': 'Network error. Please check your connection',
    'generic_error': 'Sign in failed. Please check your connection and try again',
    'signout_failed': 'Sign out failed. Please try again',
  };
  
  // Firebase Auth error code mappings
  static const Map<String, String> firebaseErrorMessages = {
    'account-exists-with-different-credential': 'An account already exists with this email address',
    'invalid-credential': 'Invalid credentials. Please try again',
    'operation-not-allowed': 'This sign-in method is not enabled',
    'user-disabled': 'This account has been disabled',
    'too-many-requests': 'Too many sign-in attempts. Please try again later',
    'network-request-failed': 'Network error. Please check your connection',
    'user-not-found': 'No account found with this email address',
    'wrong-password': 'Incorrect password. Please try again',
    'weak-password': 'Password is too weak. Please choose a stronger password',
    'email-already-in-use': 'An account already exists with this email address',
  };
  
  // Security headers (for future web implementation)
  static const Map<String, String> securityHeaders = {
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
    'X-XSS-Protection': '1; mode=block',
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
    'Content-Security-Policy': "default-src 'self'",
  };
  
  // Private constructor to prevent instantiation
  SecurityConstants._();
}
