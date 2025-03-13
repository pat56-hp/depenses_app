import 'package:depenses/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialiteController extends GetxController {
  RxBool googleLoading = false.obs;
  RxBool fbLoading = false.obs;
  RxBool gitLoading = false.obs;

  //Sign in with Google
  Future<UserCredential> userSignWithGoogle() async {
    gitLoading.value = true;

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

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign in with Facebook
  Future<void> userSignWithFacebook() async {}

  //Sign in with Github
  Future<void> userSignWithGithub() async {}

  void loadingFinish() {
    googleLoading.value = false;
    fbLoading.value = false;
    gitLoading.value = false;
  }
}
