import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:mustafacv/UI/imgdesign.dart';
import 'package:mustafacv/constant/root.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectViewController extends GetxController {
  bool animation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation = true;
      update();
    });
    super.onInit();
  }

  viewData(String data) async {
    await launchUrl(Uri.parse(data));
  }
}

class ProjectView extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> data;
  const ProjectView({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectViewController>(
      init: ProjectViewController(),
      builder: (controller) {
        return Scaffold(
          body: BgDesgin(
            page: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 400),
                  transform: Matrix4.translationValues(
                      0, controller.animation ? 0 : Get.width, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonDesign(
                        onTap: () => Get.back(),
                        iconData: Icons.arrow_back_ios_new_rounded,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(data['ImgProfile']),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['Name'],
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: Get.width / 22,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data['Dscrp'],
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: Get.width / 22,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProjectImgDesign(
                            onTap: () => controller
                                .viewData(data['Links']['GooglePlay']),
                            img: Root.googlplay,
                            visible: data['Links']['GooglePlay'] != "" &&
                                data['Links']['GooglePlay'] != null,
                          ),
                          ProjectImgDesign(
                              visible: data['Links']['Appstore'] != "" &&
                                  data['Links']['Appstore'] != null,
                              onTap: () => controller
                                  .viewData(data['Links']['Appstore']),
                              img: Root.appstore),
                          ProjectImgDesign(
                              visible: data['Links']['Mega'] != "" &&
                                  data['Links']['Mega'] != null,
                              onTap: () =>
                                  controller.viewData(data['Links']['Mega']),
                              img: Root.mega),
                          ProjectImgDesign(
                              visible: data['Links']['website'] != "" &&
                                  data['Links']['website'] != null,
                              onTap: () => controller
                                  .viewData("${data['Links']['website']}"),
                              img: Root.language),
                        ],
                      ),
                      SizedBox(
                        height: 500,
                        width: Get.width,
                        child: ListView.builder(
                            itemCount: data['ImgList'].length,
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
                                          image: NetworkImage(
                                              data['ImgList'][index]),
                                          fit: BoxFit.fill)),
                                )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
