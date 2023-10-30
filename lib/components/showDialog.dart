import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';

Future wShowDialog(context, labelTitle, text) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("$labelTitle", style: AppTextStyles.title3),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            5.0), // Ajuste o valor do raio conforme desejado
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("$text",
            textAlign: TextAlign.justify, style: AppTextStyles.heading16NBold),
      ),
      actions: [
        OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                color: AppColors.deepSkyBlue,
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.deepSkyBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5.0), // Ajuste o valor do raio conforme desejado
              ),
            ),
          ),
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
