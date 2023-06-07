import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:moneyfirst/models/default_category.dart';
import 'package:moneyfirst/net/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User> get onAuthStateChanged => _auth.authStateChanges();

  // Future<bool> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     UserCredential result = await _auth.signInWithCredential(credential);
  //     if (result.additionalUserInfo.isNewUser) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     throw e;
  //   }
  // }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("success");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOutFromGoogle() async {
    // await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      return e.code;
    }
  }

  Future<String> signUp({
    String email,
    String password,
    String currencySymbol,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(
        currency: currencySymbol,
      );
      for (var category in defaultCategory) {
        await DatabaseService(uid: user.uid).addNewCategory(
          type: category['type'],
          name: category['name'],
          color: category['color'],
        );
      }
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}


// // Future<bool> addCoin(String id, String amount) async {
// //   try {
// //     String uid = FirebaseAuth.instance.currentUser.uid;
// //     var value = double.parse(amount);
// //     DocumentReference documentReference = FirebaseFirestore.instance
// //         .collection('Users')
// //         .doc(uid)
// //         .collection('Coins')
// //         .doc(id);
// //     FirebaseFirestore.instance.runTransaction((transaction) async {
// //       DocumentSnapshot snapshot = await transaction.get(documentReference);
// //       if (!snapshot.exists) {
// //         documentReference.set({'Amount': value});
// //         return true;
// //       }
// //       double newAmount = snapshot.data()['Amount'] + value;
// //       transaction.update(documentReference, {'Amount': newAmount});
// //       return true;
// //     });
// //     return true;
// //   } catch (e) {
// //     return false;
// //   }
// // }

// // Future<bool> removeCoin(String id) async {
// //   String uid = FirebaseAuth.instance.currentUser.uid;
// //   FirebaseFirestore.instance
// //       .collection('Users')
// //       .doc(uid)
// //       .collection('Coins')
// //       .doc(id)
// //       .delete();
// //   return true;
// // }