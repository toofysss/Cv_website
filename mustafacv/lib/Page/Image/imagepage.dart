import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:path/path.dart';

class ImagePageController extends GetxController {
  final imagedata = FirebaseFirestore.instance.collection("Logo");

  String img = "", id = "", imgpath = "";
  File? imgLogo;
  @override
  void onInit() {
    getimage();
    super.onInit();
  }

  void setinglogo() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;
    imgLogo = File(img.path);
    String randomNumber = Random().nextInt(100).toString();
    imgpath = '$randomNumber${basename(img.path)}';
    update();
  }

  void operation() async {
    var firebasestorage = FirebaseStorage.instance.ref("logo/$imgpath");
    await firebasestorage.putFile(imgLogo!);
    var imglink = await firebasestorage.getDownloadURL();
    if (img.isNotEmpty) {
      imagedata.doc(id).update({"Img": imglink});
    } else {
      imagedata.add({"Img": imglink});
    }
    Get.back();
  }

  void getimage() {
    imagedata.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        img = doc["Img"];
        id = doc.id;
        update();
      }
    });
  }
}

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePageController>(
        init: ImagePageController(),
        builder: (controller) {
          return Scaffold(
              body: BgDesgin(
            page: SafeArea(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonDesign(
                          onTap: () => Get.back(),
                          iconData: Icons.arrow_back_ios_new_rounded,
                        ),
                        Text(
                          "5".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: Get.width / 18),
                        ),
                        ButtonDesign(
                          onTap: () => controller.operation(),
                          iconData: Icons.save,
                        ),
                      ],
                    ),
                  ),
                  controller.img.isNotEmpty && controller.imgLogo == null
                      ? GestureDetector(
                          onTap: () => controller.setinglogo(),
                          child: Container(
                            width: 300,
                            height: 300,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(controller.img),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : controller.imgLogo != null
                          ? GestureDetector(
                              onTap: () => controller.setinglogo(),
                              child: Container(
                                width: 300,
                                height: 300,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(controller.imgLogo!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => controller.setinglogo(),
                              child: Container(
                                width: 300,
                                height: 300,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 0),
                                          color: Theme.of(context).shadowColor)
                                    ]),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Icon(
                                  Icons.image,
                                  size: Get.width / 7,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                ],
              ),
            )),
          ));
        });
  }
}
