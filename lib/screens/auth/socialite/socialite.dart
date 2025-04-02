import 'package:depenses/screens/auth/widgets/facebook_authentication.dart';
import 'package:depenses/screens/auth/widgets/github_authentication.dart';
import 'package:depenses/screens/auth/widgets/google_authentication.dart';
import 'package:flutter/material.dart';

class Socialite extends StatefulWidget {
  const Socialite({super.key});

  @override
  State<Socialite> createState() => _SocialiteState();
}

class _SocialiteState extends State<Socialite> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //FacebookAuthentication(),
        GithubAuthentication(),
        GoogleAuthentication(),
      ],
    );
  }
}
