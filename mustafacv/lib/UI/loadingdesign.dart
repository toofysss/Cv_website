import 'package:flutter/material.dart';

class LoadingDesign extends StatelessWidget {
  const LoadingDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).shadowColor)));
  }
}
