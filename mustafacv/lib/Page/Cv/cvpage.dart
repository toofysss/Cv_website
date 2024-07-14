import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:path/path.dart';

class CvPageController extends GetxController {
  final imagedata = FirebaseFirestore.instance.collection("About");

  String cvpath = "", id = "";
  File? cvPdf;
  @override
  void onInit() {
    getCv();
    super.onInit();
  }

  void setingCv() async {
    var img = await ImagePicker().pickMedia();
    if (img == null) return;
    cvPdf = File(img.path);
    cvpath = basename(img.path);
    update();
  }

  operation() async {
    var firebasestorage = FirebaseStorage.instance.ref("Cv/$cvpath");
    await firebasestorage.putFile(cvPdf!);
    var imglink = await firebasestorage.getDownloadURL();
    imagedata.doc(id).update({"linkCv": imglink});
    Get.back();
  }

  getCv() {
    imagedata.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        id = doc.id;
        update();
      }
    });
  }
}

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CvPageController>(
        init: CvPageController(),
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
                          "6".tr,
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
                  GestureDetector(
                    onTap: () => controller.setingCv(),
                    child: Container(
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).scaffoldBackgroundColor,
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
                        Icons.picture_as_pdf_rounded,
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
