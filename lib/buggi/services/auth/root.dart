import 'package:app/buggi/components/widgets/info_widgets.dart';
import 'package:app/common_libs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuggiAuth {
  static String success = '200';
  static bool get userIsAuthenticated {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<bool> checkIfUserExists(String email) async {
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return methods.isNotEmpty;
  }

  static Future<bool> logOutUser() async {
    bool proceed = await ConfirmationDialog.show('Log Out');
    if (proceed) {
      await FirebaseAuth.instance.signOut();
      return true;
    } else {
      return false;
    }
  }

  static Future<String> emailSignIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'An undefined Error happened.';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> emailSignUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return 'An undefined Error happened.';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<void> forgotPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static User get user => FirebaseAuth.instance.currentUser!;
}

class NoSQLDb {
  static final NoSQLDb _instance = NoSQLDb._();
  static NoSQLDb get instance => _instance;
  factory NoSQLDb() => _instance;
  NoSQLDb._();
  SharedPreferences? preferences;

  static Future<void> init() async {
    try {
      instance.preferences = await SharedPreferences.getInstance();
    } catch (e) {}
  }

  static Future<void> updatePhoneNumber(String phone) async {
    await instance.preferences!.setString('phone_number', phone);
  }

  static String? get phoneNumber {
    try {
      String? phone = instance.preferences!.getString('phone_number');
      return phone;
    } catch (e) {
      return '';
    }
  }
}
