import 'package:depenses/utils/colors.dart';
import 'package:flutter/material.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 30,
        width: size ?? 30,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.secondary,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
