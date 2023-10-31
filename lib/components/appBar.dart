import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/components/showDialog.dart';

AppBar wAppbar(context, labelTitle, text) {
  return AppBar(
    actions: [
      IconButton(
        color: Colors.black,
        onPressed: () {
          wShowDialog(context, labelTitle, text);
        },
        icon: const Icon(Icons.info_outline_rounded),
      ),
    ],
    backgroundColor: AppColors.deepSkyBlue,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    title: Text(
      '$labelTitle',
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
