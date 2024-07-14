import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/Page/Project/project.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/buttondesign.dart';
import 'package:mustafacv/UI/customtextfield.dart';

class ProjectHeaderOperationController extends GetxController {
  ProjectController homeController = Get.put(ProjectController());
  get projectdata => homeController.projectheaderData;

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController titlecontrollerA = TextEditingController();
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
      projectdata.doc(id).update({
        "Title": titlecontroller.text,
        "TitleA": titlecontrollerA.text,
      });
    } else {
      projectdata.add({
        "Title": titlecontroller.text,
        "TitleA": titlecontrollerA.text,
      });
    }
    Get.back();
  }
}

class ProjectHeaderOperation extends StatelessWidget {
  final bool edit;
  final String? id;
  final String title;
  final String titleA;
  const ProjectHeaderOperation(
      {this.id,
      this.edit = false,
      this.title = '',
      this.titleA = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectHeaderOperationController>(
        init: ProjectHeaderOperationController(),
        builder: (controller) {
          controller.titlecontroller.text = title;
          controller.titlecontrollerA.text = titleA;
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
                  ],
                ),
              ),
            ))),
          );
        });
  }
}
