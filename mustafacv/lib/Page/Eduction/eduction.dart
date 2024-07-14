import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:mustafacv/UI/customtextfield.dart';
import 'package:mustafacv/UI/design.dart';
import 'package:mustafacv/UI/loadingdesign.dart';
import 'package:mustafacv/constant/root.dart';

class EductionController extends GetxController {
  final eductiondata = FirebaseFirestore.instance.collection("Eduction");

  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  delete(String id) {
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
                      eductiondata.doc(id).delete();
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

class EductionOperationController extends GetxController {
  EductionController homeController = Get.put(EductionController());
  get eductiondata => homeController.eductiondata;

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController subtitlecontroller = TextEditingController();
  TextEditingController titlecontrollerA = TextEditingController();
  TextEditingController subtitlecontrollerA = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  operation(bool edit, String id) {
    if (edit) {
      eductiondata.doc(id).update({
        "Title": titlecontroller.text,
        "Dscrp": subtitlecontroller.text,
        "TitleA": titlecontrollerA.text,
        "DscrpA": subtitlecontrollerA.text,
        "year": datecontroller.text,
      });
    } else {
      eductiondata.add({
        "Title": titlecontroller.text,
        "Dscrp": subtitlecontroller.text,
        "TitleA": titlecontrollerA.text,
        "DscrpA": subtitlecontrollerA.text,
        "year": datecontroller.text,
      });
    }
    Get.back();
  }
}

class Eduction extends StatelessWidget {
  const Eduction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EductionController>(
        init: EductionController(),
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
                          "1".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: Get.width / 18),
                        ),
                        ButtonDesign(
                          onTap: () => Get.to(() => const EductionOperation(),
                              transition: Transition.zoom),
                          iconData: Icons.add,
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: controller.eductiondata.snapshots(),
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
                                          controller.delete(data.id),
                                      onUpdate: () => Get.to(
                                          () => EductionOperation(
                                              title: data['Title'],
                                              titleA: data['TitleA'],
                                              dscrp: data['Dscrp'],
                                              dscrpA: data['DscrpA'],
                                              date: data['year'],
                                              edit: true,
                                              id: data.id),
                                          transition: Transition.fadeIn),
                                      title: data[Root.lang == "en"
                                          ? 'Title'
                                          : 'TitleA']);
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

class EductionOperation extends StatelessWidget {
  final bool edit;
  final String? id;
  final String titleA;
  final String title;
  final String dscrpA;
  final String dscrp;
  final String date;
  const EductionOperation(
      {this.id,
      this.edit = false,
      super.key,
      this.titleA = '',
      this.title = '',
      this.dscrpA = '',
      this.dscrp = '',
      this.date = ''});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EductionOperationController>(
        init: EductionOperationController(),
        builder: (controller) {
          controller.titlecontroller.text = title;
          controller.titlecontrollerA.text = titleA;
          controller.subtitlecontroller.text = dscrp;
          controller.subtitlecontrollerA.text = dscrpA;
          controller.datecontroller.text = date;
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
                            onTap: () => controller.operation(edit, "$id"),
                            iconData: Icons.save_rounded,
                          ),
                        ],
                      ),
                    ),
                    CustomtextField(
                        hint: "${"7".tr} ${"Ar".tr}",
                        textEditingController: controller.titlecontroller),
                    CustomtextField(
                        hint: "${"7".tr} ${"En".tr}",
                        textEditingController: controller.titlecontrollerA),
                    CustomtextField(
                        hint: "${"8".tr} ${"Ar".tr}",
                        textEditingController: controller.subtitlecontroller),
                    CustomtextField(
                        hint: "${"8".tr} ${"En".tr}",
                        textEditingController: controller.subtitlecontrollerA),
                    CustomtextField(
                        hint: "6".tr,
                        textEditingController: controller.datecontroller),
                  ],
                ),
              ),
            ))),
          );
        });
  }
}
