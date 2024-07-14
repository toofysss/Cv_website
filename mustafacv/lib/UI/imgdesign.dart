import 'package:flutter/material.dart';

class ProjectImgDesign extends StatelessWidget {
  final String img;
  final Function()? onTap;
  final bool visible;
  const ProjectImgDesign(
      {required this.img,
      required this.visible,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return visible
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(vertical: 10),
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
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              ),
            ),
          )
        : const Center();
  }
}
