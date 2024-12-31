import 'package:flutter/material.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({super.key, this.size, this.color});

  final double? size;
  final Color? color;
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).colorScheme.secondary,
        strokeWidth: size ?? 4.0
      ),
    );
  }
}