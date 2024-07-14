import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustafacv/constant/root.dart';
import '../services/services.dart';

class LocalController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  setLanguage(String lang) {
    language = Locale(lang);
    Root.lang = lang;
  }

  getlang() {
    String? lang = myServices.sharedPreferences.getString("lang");
    lang != null
        ? setLanguage(lang)
        : setLanguage(Get.deviceLocale!.languageCode);
  }

  @override
  void onInit() {
    getlang();
    super.onInit();
  }
}
