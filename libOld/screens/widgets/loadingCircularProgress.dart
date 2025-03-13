import 'package:depenses/utils/colors.dart';
import 'package:flutter/material.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: color ?? AppColor.buttonDarkColor,
    );
  }
}
