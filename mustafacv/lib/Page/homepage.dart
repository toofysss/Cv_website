import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/UI/bgdesign.dart';
import 'package:mustafacv/UI/carddesign.dart';
import 'package:mustafacv/constant/root.dart';
import 'package:mustafacv/localization/changelocal.dart';
import 'package:mustafacv/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeData {
  final Function()? onTap;
  final IconData iconData;

  HomeData({
    required this.iconData,
    required this.onTap,
  });
}

class HomePageController extends GetxController {
  MyServices myServices = Get.put(MyServices());
  LocalController localController = Get.put(LocalController());
  bool isDark = true, startAnimation = false;
  List<HomeData> setting = [];

  @override
  void onInit() {
    setting = [
      HomeData(iconData: Icons.language, onTap: () => changelang()),
      HomeData(
          iconData: Icons.web,
          onTap: () => viewData("https://mustafa--cv.web.app/")),
    ];
    animation();
    super.onInit();
  }

  animation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startAnimation = true;
      update();
    });
  }

  viewData(String data) async {
    await launchUrl(Uri.parse(data));
  }

  void changelang() {
    Root.lang == "en" ? Root.lang = "ar" : Root.lang = "en";
    localController.language = Locale(Root.lang);
    Get.updateLocale(localController.language!);
    myServices.sharedPreferences.setString("lang", Root.lang);
    update();
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
              body: BgDesgin(
            page: SafeArea(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "App".tr,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width / 18),
                      ),
                      PopupMenuButton(
                          constraints: const BoxConstraints(maxWidth: 70),
                          iconColor: Theme.of(context).primaryColor,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shadowColor: Theme.of(context).shadowColor,
                          itemBuilder: (context) => List.generate(
                              controller.setting.length,
                              (index) => PopupMenuItem(
                                    onTap: controller.setting[index].onTap,
                                    child: Center(
                                      child: Icon(
                                        controller.setting[index].iconData,
                                        size: Get.width / 16,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ))),
                    ],
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 35),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 30,
                              mainAxisExtent: 100,
                              crossAxisSpacing: 30),
                      itemCount: 7,
                      itemBuilder: ((context, index) => AnimatedContainer(
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(milliseconds: 300 + (index * 200)),
                          transform: Matrix4.translationValues(
                              0, controller.startAnimation ? 0 : Get.width, 0),
                          child: CardDesign(index: index))))
                ],
              ),
            )),
          ));
        });
  }
}
