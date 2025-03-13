import 'package:flutter/material.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.secondary,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
