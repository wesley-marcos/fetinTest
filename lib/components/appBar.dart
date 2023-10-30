import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';

AppBar wAppbar(context, labelTittle) {
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
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    "Alternativa é toda opção de escolha que você "
                    "tem.\n\n"
                    "Exemplo\nAo comprar um computador, você tem "
                    "as três alternativas seguintes: um da marca Acer, "
                    "um da marca "
                    "Dell e outro da marca Apple.",
                    textAlign: TextAlign.justify,
                    style: AppTextStyles.heading16NBold),
              ),
              actions: [
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.blue),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
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
