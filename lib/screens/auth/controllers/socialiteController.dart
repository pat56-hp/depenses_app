import 'package:depenses/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialiteController extends GetxController {
  RxBool googleLoading = false.obs;
  RxBool fbLoading = false.obs;
  RxBool gitLoading = false.obs;

  //Sign in with Google
  Future<UserCredential> userSignWithGoogle() async {
    googleLoading.value = true;

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: (DefaultFirebaseOptions.currentPlatform ==
                    DefaultFirebaseOptions.ios)
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : DefaultFirebaseOptions.currentPlatform.androidClientId)
        .signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign in with Facebook
  Future<UserCredential> userSignWithFacebook() async {
    fbLoading.value = true;

    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  //Sign in with Github
  Future<UserCredential> userSignWithGithub() async {
    try {
      gitLoading.value = true;
      GithubAuthProvider githubAuthProvider = GithubAuthProvider();
      return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
    } on FirebaseAuthException catch (e) {
      print('Error signing in with Github: ${e.message}');
      print('Error code ${e.code}');
      throw e;
    } finally {
      gitLoading.value = false;
    }
  }

  void loadingFinish() {
    googleLoading.value = false;
    fbLoading.value = false;
    gitLoading.value = false;
  }
}
