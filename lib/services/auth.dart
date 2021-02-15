import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kabakv1/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges().map((User user) => user);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    bool isInitialized =
        await DatabaseService(userUid: result.user.uid).doesUserExists();

    // If user is not initialized in database, initialize it
    if (!isInitialized) {
      await _addUserToDatabase(result);
    }
    return result;
  }

  Future _addUserToDatabase(UserCredential result) async {
    await DatabaseService(userUid: result.user.uid).updateUserData(
        name: result.user.displayName ?? 'New User',
        email: result.user.email,
        activeLessons: [],
        sex: true,
        registerationDate: DateTime.now().toString(),
        totalCredit: 0);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } catch (e) {
      return e.toString();
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _addUserToDatabase(result);
      return result.user;
      ;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
