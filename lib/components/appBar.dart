import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';

AppBar wAppbar(context, labelTittle, text) {
  return AppBar(
    actions: [
      IconButton(
        color: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("$labelTittle", style: AppTextStyles.title3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5.0), // Ajuste o valor do raio conforme desejado
              ),
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("$text",
                    textAlign: TextAlign.justify,
                    style: AppTextStyles.heading16NBold),
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
        },
        icon: const Icon(Icons.info_outline_rounded),
      ),
    ],
    backgroundColor: AppColors.deepSkyBlue,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    title: Text(
      '$labelTittle',
      style: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(1, 4),
            blurRadius: 3,
          )
        ],
      ),
    ),
    centerTitle: true,
  );
}
