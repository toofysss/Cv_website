import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/Page/Cv/cvpage.dart';
import 'package:mustafacv/Page/Eduction/eduction.dart';
import 'package:mustafacv/Page/Experience/experience.dart';
import 'package:mustafacv/Page/Home/home.dart';
import 'package:mustafacv/Page/Image/imagepage.dart';
import 'package:mustafacv/Page/Project/project.dart';
import 'package:mustafacv/Page/Skills/skills.dart';

class CardDesign extends StatelessWidget {
  final int index;
  const CardDesign({required this.index, super.key});

  Widget page(int page) {
    switch (page) {
      case 0:
        return const Home();
      case 1:
        return const Eduction();
      case 2:
        return const Experience();
      case 3:
        return const Skills();
      case 4:
        return const Project();
      case 5:
        return const ImagePage();
      case 6:
        return const CvPage();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => page(index), transition: Transition.zoom),
      child: Container(
        alignment: Alignment.center,
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
        child: Text(
          "$index".tr,
          style: TextStyle(
              fontSize: Get.width / 22,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
