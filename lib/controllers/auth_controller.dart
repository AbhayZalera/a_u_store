import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/consts.dart';

class AuthController extends GetxController {
  // Observables and TextControllers
  var isloading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login with email and password method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Google Sign-In method
  Future<User?> googleSignInMethod({required BuildContext context}) async {
    try {
      // First, sign out from any existing Google account to prompt a new account selection
      await GoogleSignIn().signOut();

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain auth details from the Google sign-in request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential using the token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      // Check if the user is new or existing, if new then store data
      if (userCredential.additionalUserInfo!.isNewUser) {
        await storeUserData(
          name: user!.displayName,
          email: user.email,
          password: '123456', // Placeholder password for Google Sign-In
        );
      }

      return user;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      return null;
    }
  }

  // Sign-Up method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Method to store user data in Firestore
  Future<void> storeUserData({name, password, email}) async {
    DocumentReference store = fireStore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': 0,
      'wishlist_count': 0,
      'order_count': 0,
    });
  }

  // Sign-out method
  Future<void> signoutMethod(BuildContext context) async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut(); // Sign out from Google as well
      VxToast.show(context, msg: "Logged out successfully.");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // Method to delete chat
  static Future<void> deleteChat(String chatDocId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocId)
        .delete();
  }
}
