import 'dart:convert';

import 'package:depenses/firebase_options.dart';
import 'package:depenses/screens/auth/widgets/ButtonOtherLogin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Socialite extends StatefulWidget {
  const Socialite({super.key});

  @override
  State<Socialite> createState() => _SocialiteState();
}

class _SocialiteState extends State<Socialite> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonOtherLogin(
          image: 'assets/images/facebook.png',
          onPress: () {},
        ),
        ButtonOtherLogin(
          image: 'assets/images/github.png',
          onPress: () {},
        ),
        ButtonOtherLogin(
          image: 'assets/images/google.png',
          onPress: () async {
            try {
              print('is pressed');
              final UserCredential userCredential = await userSignWithGoogle();
              print('User credentials : ' + userCredential.user.toString());
            } catch (e) {
              print('Error : ' + e.toString());
            }
          },
        )
      ],
    );
  }

  //Sign in with Google
  Future<UserCredential> userSignWithGoogle() async {
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
}
