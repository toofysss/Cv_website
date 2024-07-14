import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustafacv/Page/Project/project.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:mustafacv/UI/customtextfield.dart';
import 'package:mustafacv/UI/design.dart';
import 'package:mustafacv/UI/loadingdesign.dart';
import 'viewproject.dart';
import 'package:path/path.dart';

class ProjectDataController extends GetxController {
  ProjectController homeController = Get.put(ProjectController());
  get projectdata => homeController.projectheaderData;
  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  delete(String id, String doc) {
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
                      projectdata
                          .doc(doc)
                          .collection('Program')
                          .doc(id)
                          .delete();
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

class ProjectDataOperationController extends GetxController {
  ProjectController homeController = Get.put(ProjectController());
  get projectdata => homeController.projectheaderData;
  File? imgprofile;

  String imgprofilePath = '';
  List<File> imglist = [];
  TextEditingController title = TextEditingController();
  TextEditingController dscrp = TextEditingController();
  TextEditingController googlePlay = TextEditingController();
  TextEditingController appStore = TextEditingController();
  TextEditingController mega = TextEditingController();
  TextEditingController website = TextEditingController();
  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  setimgprofile() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;
    imgprofile = File(img.path);
    String randomNumber = Random().nextInt(100).toString();
    imgprofilePath = '$randomNumber${basename(img.path)}';
    update();
  }

  setlistimg() async {
    List img = await ImagePicker().pickMultiImage();
    if (img.isEmpty) return;
    imglist = img.map((xFile) => File(xFile.path)).toList();
    update();
  }

  operation(bool edit, String id, var data) async {
    showGeneralDialog(
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
                  child: CircularProgressIndicator(
                color: Theme.of(context).shadowColor,
              )),
              actionsAlignment: MainAxisAlignment.center,
            ),
          ),
        );
      },
    );

    if (edit) {
      data.doc(id).update({
        "Dscrp": dscrp.text,
        "Name": title.text,
        "Links": {
          "Appstore": appStore.text,
          "GooglePlay": googlePlay.text,
          "Mega": mega.text,
          "Website": website.text,
        }
      });
    } else {
      var firebasestorage =
          FirebaseStorage.instance.ref("Project/$imgprofilePath");
      await firebasestorage.putFile(imgprofile!);
      var imglink = await firebasestorage.getDownloadURL();
      List imgpath = [];
      for (int i = 0; i < imglist.length; i++) {
        String randomNumber = Random().nextInt(100).toString();
        String imgloc = '$randomNumber${basename(imglist[i].path)}';

        var firebasestorageList =
            FirebaseStorage.instance.ref("Project/$imgloc");

        await firebasestorageList.putFile(File(imglist[i].path));
        var link = await firebasestorageList.getDownloadURL();
        imgpath.add(link);
      }
      data.add({
        "Dscrp": dscrp.text,
        "Name": title.text,
        "ImgProfile": imglink,
        "ImgList": imgpath,
        "Links": {
          "Appstore": appStore.text,
          "GooglePlay": googlePlay.text,
          "Mega": mega.text,
          "Website": website.text,
        }
      });
    }
    Get.back();
    Get.back();
  }
}

class ProjectData extends StatelessWidget {
  final String id;
  final String title;
  const ProjectData({required this.id, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDataController>(
        init: ProjectDataController(),
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
                              () => ProjectDataOperation(
                                    data: controller.projectdata
                                        .doc(id)
                                        .collection('Program'),
                                  ),
                              transition: Transition.zoom),
                          iconData: Icons.add,
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: controller.projectdata
                            .doc(id)
                            .collection('Program')
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
                                  QueryDocumentSnapshot<Object?> data =
                                      snap.data!.docs[index];

                                  return GestureDetector(
                                    onTap: () => Get.to(
                                        () => ProjectView(data: data),
                                        transition: Transition.fadeIn),
                                    child: Design(
                                        img: data['ImgProfile'],
                                        onDelete: () =>
                                            controller.delete(data.id, id),
                                        onUpdate: () => Get.to(
                                            () => ProjectDataOperation(
                                                  edit: true,
                                                  id: data.id,
                                                  img: data['ImgProfile'],
                                                  links: data['Links'],
                                                  imglist: data['ImgList'],
                                                  dscrp: data['Dscrp'],
                                                  title: data['Name'],
                                                  data: controller.projectdata
                                                      .doc(id)
                                                      .collection('Program'),
                                                ),
                                            transition: Transition.fadeIn),
                                        title: data['Name']),
                                  );
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

class ProjectDataOperation extends StatelessWidget {
  final bool edit;
  final String? id;
  final CollectionReference<Map<String, dynamic>> data;
  final String img;
  final String title;
  final String dscrp;
  final List imglist;
  final Map? links;

  const ProjectDataOperation(
      {this.id,
      required this.data,
      this.edit = false,
      this.img = '',
      this.dscrp = '',
      this.imglist = const [],
      this.links = const {},
      this.title = '',
      super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDataOperationController>(
        init: ProjectDataOperationController(),
        builder: (controller) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        img.isNotEmpty && controller.imgprofile == null
                            ? GestureDetector(
                                onTap: () => controller.setimgprofile(),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(img),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            : img.isEmpty && controller.imgprofile != null
                                ? GestureDetector(
                                    onTap: () => controller.setimgprofile(),
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              FileImage(controller.imgprofile!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => controller.setimgprofile(),
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 0),
                                                color: Theme.of(context)
                                                    .shadowColor)
                                          ]),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Icon(
                                        Icons.image,
                                        size: Get.width / 7,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                        GestureDetector(
                          onTap: () => controller.setlistimg(),
                          child: Container(
                            width: 120,
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                    CustomtextField(
                        hint: "7".tr, textEditingController: controller.title),
                    CustomtextField(
                        hint: "8".tr, textEditingController: controller.dscrp),
                    CustomtextField(
                        hint: "Google Play",
                        textEditingController: controller.googlePlay),
                    CustomtextField(
                        hint: "AppStore",
                        textEditingController: controller.appStore),
                    CustomtextField(
                        hint: "Mega", textEditingController: controller.mega),
                    CustomtextField(
                        hint: "Website",
                        textEditingController: controller.website),
                    SizedBox(
                      height: 500,
                      width: Get.width,
                      child: ListView.builder(
                          itemCount: controller.imglist.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        image: FileImage(
                                            controller.imglist[index]),
                                        fit: BoxFit.fill)),
                              )),
                    )
                  ],
                ),
              ),
            ))),
          );
        });
  }
}
