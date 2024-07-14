import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonDesign extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  const ButtonDesign({required this.onTap, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                  color: Theme.of(context).shadowColor)
            ]),
        child: Icon(
          iconData,
          size: Get.width / 18,
        ),
      ),
    );
  }
}
