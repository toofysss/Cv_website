import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomtextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hint;
  const CustomtextField(
      {required this.hint, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: Get.width * .9,
      alignment: Alignment.center,
      child: TextField(
        controller: textEditingController,
        style: TextStyle(
          fontSize: Get.width / 18,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          labelText: hint,
          labelStyle: TextStyle(
              fontSize: Get.width / 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor.withOpacity(.7)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide:
                BorderSide(width: 2, color: Theme.of(context).shadowColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide:
                BorderSide(width: 2, color: Theme.of(context).shadowColor),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
