part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<SignInSignUpResult> signIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      AuthResult authResult = await _auth.signInWithCredential(credential);
      Users users = authResult.user.convertToUser();
      await UserServices.updateUser(users);
      return SignInSignUpResult(user: users);
    } catch (e) {
      print("TEs");
      print(e.toString());
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;

  static Future<SignInSignUpResult> signOut() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await _auth.signOut();
      await googleSignIn.signOut();
      print("User Sign Out");
    } catch (e) {
      print(e.toString());
    }
    return SignInSignUpResult(message: "tes");
  }
}

class SignInSignUpResult {
  final Users user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
