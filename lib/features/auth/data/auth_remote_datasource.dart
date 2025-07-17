import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<User> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // User canceled the sign-in
      throw Exception('Google Sign-In aborted by user.');
    }

    // Your specific email domain check
    if (!googleUser.email.endsWith('@psgtech.ac.in')) {
      await googleSignIn.signOut(); // Sign out the user
      throw Exception('Only @psgtech.ac.in emails are allowed.');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);

    if (userCredential.user == null) {
      throw Exception('Sign-in failed, user not found.');
    }

    return userCredential.user!;
  }
}
