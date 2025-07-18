import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;
import '../core/constants/security_constants.dart';

/// Secure authentication service that handles all authentication operations
/// with proper security measures and error handling
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: SecurityConstants.googleSignInScopes,
    forceCodeForRefreshToken: true,
    // Add custom configuration to show better app name
    hostedDomain: null, // Allow any domain
    clientId: null, // Use default client ID from google-services.json
  );

  // Security: Rate limiting for authentication attempts
  DateTime? _lastAuthAttempt;
  int _failedAttempts = 0;

  /// Get current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Check if user is currently signed in
  bool get isSignedIn => currentUser != null;

  /// Security: Check if authentication attempt is allowed
  bool _canAttemptAuth() {
    if (_failedAttempts >= SecurityConstants.maxFailedAttempts) {
      developer.log('Max failed attempts reached', name: SecurityConstants.authSecurityLogName);
      return false;
    }
    
    if (_lastAuthAttempt == null) return true;
    return DateTime.now().difference(_lastAuthAttempt!) >= SecurityConstants.minAuthInterval;
  }

  /// Security: Reset failed attempts counter on successful auth
  void _resetFailedAttempts() {
    _failedAttempts = 0;
  }

  /// Security: Increment failed attempts counter
  void _incrementFailedAttempts() {
    _failedAttempts++;
  }

  /// Security: Validate JWT token structure
  bool _isValidJwtToken(String? token) {
    if (token == null || token.isEmpty) return false;
    final parts = token.split('.');
    return parts.length == SecurityConstants.jwtMinParts && parts.every((part) => part.isNotEmpty);
  }

  /// Security: Sanitize user input
  String _sanitizeString(String? input) {
    if (input == null || input.isEmpty) return '';
    final sanitized = input
        .replaceAll(SecurityConstants.htmlSanitizationPattern, '')
        .replaceAll(SecurityConstants.specialCharacterPattern, '')
        .trim();
    return sanitized.length > SecurityConstants.maxDisplayNameLength 
        ? sanitized.substring(0, SecurityConstants.maxDisplayNameLength) 
        : sanitized;
  }

  /// Secure Google Sign-In with comprehensive validation
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Security: Rate limiting check
      if (!_canAttemptAuth()) {
        return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['rate_limited']!);
      }

      _lastAuthAttempt = DateTime.now();

      // Attempt Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['cancelled']!);
      }

      // Security: Validate email exists
      if (googleUser.email.isEmpty) {
        developer.log('Google sign-in with empty email', name: SecurityConstants.authSecurityLogName);
        _incrementFailedAttempts();
        return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['invalid_account']!);
      }

      // Get authentication credentials
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Security: Validate tokens
      if (!_isValidJwtToken(googleAuth.idToken)) {
        developer.log('Invalid ID token received', name: SecurityConstants.authSecurityLogName);
        _incrementFailedAttempts();
        return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['invalid_credentials']!);
      }

      if (googleAuth.accessToken == null || googleAuth.accessToken!.isEmpty) {
        developer.log('Invalid access token received', name: SecurityConstants.authSecurityLogName);
        _incrementFailedAttempts();
        return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['invalid_token']!);
      }

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      if (userCredential.user == null) {
        developer.log('Firebase sign-in succeeded but user is null', name: SecurityConstants.authErrorLogName);
        _incrementFailedAttempts();
        return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['auth_failed']!);
      }

      // Security: Log successful authentication
      final user = userCredential.user!;
      developer.log('User authenticated: ${user.uid}', name: SecurityConstants.authSuccessLogName);
      
      // Security: Check if email is verified (for awareness, not blocking)
      if (!user.emailVerified && user.email != null) {
        developer.log('User signed in with unverified email: ${user.email}', name: SecurityConstants.authInfoLogName);
      }

      _resetFailedAttempts();
      return AuthResult.success(user);

    } on FirebaseAuthException catch (e) {
      developer.log('Firebase Auth Error: ${e.code} - ${e.message}', name: SecurityConstants.authErrorLogName);
      _incrementFailedAttempts();
      
      final userMessage = _getFirebaseAuthErrorMessage(e.code);
      return AuthResult.failure(userMessage);
      
    } catch (e) {
      developer.log('Unexpected auth error: $e', name: SecurityConstants.authErrorLogName);
      _incrementFailedAttempts();
      return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['generic_error']!);
    }
  }

  /// Secure sign out from all services
  Future<AuthResult> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      
      developer.log('User signed out successfully', name: SecurityConstants.authSuccessLogName);
      _resetFailedAttempts();
      return AuthResult.success(null);
      
    } catch (e) {
      developer.log('Sign out error: $e', name: SecurityConstants.authErrorLogName);
      return AuthResult.failure(SecurityConstants.userFriendlyErrorMessages['signout_failed']!);
    }
  }

  /// Get user-friendly error message for Firebase Auth errors
  String _getFirebaseAuthErrorMessage(String errorCode) {
    return SecurityConstants.firebaseErrorMessages[errorCode] ?? 
           SecurityConstants.userFriendlyErrorMessages['generic_error']!;
  }

  /// Get sanitized user display information
  UserDisplayInfo getUserDisplayInfo() {
    final user = currentUser;
    if (user == null) {
      return UserDisplayInfo.empty();
    }

    return UserDisplayInfo(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName != null ? _sanitizeString(user.displayName!) : 'User',
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }
}

/// Result wrapper for authentication operations
class AuthResult {
  final bool isSuccess;
  final String? errorMessage;
  final User? user;

  AuthResult._(this.isSuccess, this.errorMessage, this.user);

  factory AuthResult.success(User? user) => AuthResult._(true, null, user);
  factory AuthResult.failure(String message) => AuthResult._(false, message, null);
}

/// Secure user display information
class UserDisplayInfo {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final bool isEmailVerified;

  UserDisplayInfo({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.isEmailVerified,
  });

  factory UserDisplayInfo.empty() => UserDisplayInfo(
    uid: '',
    email: '',
    displayName: 'User',
    isEmailVerified: false,
  );

  bool get isEmpty => uid.isEmpty;
}
