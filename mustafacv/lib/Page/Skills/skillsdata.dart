import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/Page/Skills/skills.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:mustafacv/UI/customtextfield.dart';
import 'package:mustafacv/UI/design.dart';
import 'package:mustafacv/UI/loadingdesign.dart';

class SkillsDataController extends GetxController {
  SkillsController homeController = Get.put(SkillsController());
  get skillsdata => homeController.skillsheaderData;
  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  delete(String id, doc) {
    return showGeneralDialog(
      context: Get.context!,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: .5, end: 1).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: .5, end: 1).animate(a1),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Center(
                child: Text(
                  "Warning".tr,
                  style: TextStyle(
                      fontSize: Get.width / 22,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                GestureDetector(
                    onTap: () {
                      skillsdata.doc(doc).collection('Skills').doc(id).delete();
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                        CupertinoIcons.check_mark_circled_solid,
                        size: Get.width / 16,
                        color: Theme.of(context).shadowColor,
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SkillsDataOperationController extends GetxController {
  SkillsController homeController = Get.put(SkillsController());
  get skillsdata => homeController.skillsheaderData;
  TextEditingController lang = TextEditingController();
  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  operation(bool edit, String id, var data) {
    if (edit) {
      data.doc(id).update({"lang": lang.text});
    } else {
      data.add({"lang": lang.text});
    }
    Get.back();
  }
}

class SkillsData extends StatelessWidget {
  final String title;
  final String id;
  const SkillsData({required this.title, required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkillsDataController>(
        init: SkillsDataController(),
        builder: (controller) {
          return Scaffold(
            body: BgDesgin(
                page: SafeArea(
                    child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 400),
                transform: Matrix4.translationValues(
                    0, controller.animation ? 0 : Get.width, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonDesign(
                          onTap: () => Get.back(),
                          iconData: Icons.arrow_back_ios_new_rounded,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: Get.width / 18),
                        ),
                        ButtonDesign(
                          onTap: () => Get.to(
                              () => SkillsDataOperation(
                                    data: controller.skillsdata
                                        .doc(id)
                                        .collection('Skills'),
                                  ),
                              transition: Transition.zoom),
                          iconData: Icons.add,
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: controller.skillsdata
                            .doc(id)
                            .collection('Skills')
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                          if (snap.hasData) {
                            return ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snap.data!.docs.length,
                                itemBuilder: (_, index) {
                                  var data = snap.data!.docs[index];

                                  return Design(
                                      onDelete: () =>
                                          controller.delete(data.id, id),
                                      onUpdate: () => Get.to(
                                          () => SkillsDataOperation(
                                                lang: data['lang'],
                                                edit: true,
                                                id: data.id,
                                                data: controller.skillsdata
                                                    .doc(id)
                                                    .collection('Skills'),
                                              ),
                                          transition: Transition.fadeIn),
                                      title: data['lang']);
                                });
                          }
                          return const LoadingDesign();
                        })
                  ],
                ),
              ),
            ))),
          );
        });
  }
}

class SkillsDataOperation extends StatelessWidget {
  final bool edit;
  final String? id;
  final String lang;
  final CollectionReference<Map<String, dynamic>> data;
  const SkillsDataOperation(
      {this.id,
      this.edit = false,
      this.lang = '',
      required this.data,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkillsDataOperationController>(
        init: SkillsDataOperationController(),
        builder: (controller) {
          controller.lang.text = lang;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: BgDesgin(
                page: SafeArea(
                    child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 400),
                transform: Matrix4.translationValues(
                    0, controller.animation ? 0 : Get.width, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonDesign(
                            onTap: () => Get.back(),
                            iconData: Icons.arrow_back_ios_new_rounded,
                          ),
                          ButtonDesign(
                            onTap: () =>
                                controller.operation(edit, "$id", data),
                            iconData: Icons.save_rounded,
                          ),
                        ],
                      ),
                    ),
                    CustomtextField(
                        hint: "9".tr, textEditingController: controller.lang),
                  ],
                ),
              ),
            ))),
          );
        });
  }
}
