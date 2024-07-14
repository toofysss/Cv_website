import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'localization/changelocal.dart';
import 'Page/homepage.dart';
import 'localization/translation.dart';
import 'services/services.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialservices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalController>(
        init: LocalController(),
        builder: (controller) {
          return GetMaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color(0xff1f242d),
                shadowColor: const Color(0xff0ff0ef),
                primaryColor: Colors.white),
            locale: controller.language,
            debugShowCheckedModeBanner: false,
            translations: MyTransition(),
            home: const Homepage(),
          );
        });
  }
}
