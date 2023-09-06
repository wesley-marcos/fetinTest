import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appColors.dart';

class AppTextStyles {
  // Style para a frase da tela de login
  static final TextStyle text1 = GoogleFonts.notoSans(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400);

  // Style para o botão de "Sign Up"
  static final TextStyle signupText = GoogleFonts.notoSans(
      color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold);

  // Style para os títulos
  static final TextStyle title = GoogleFonts.notoSans(
      color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold);

  static final TextStyle title2 = GoogleFonts.notoSans(
      color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold);

  static final TextStyle title3 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: Colors.grey.withOpacity(0.5),
        offset: const Offset(1, 2),
        blurRadius: 3,
      )
    ],
  );

  static final TextStyle heading15 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading15Nbold = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle heading16 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading16NBold = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 16,
  );

  static final TextStyle bodyWhite = GoogleFonts.notoSans(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodybold18 = GoogleFonts.notoSans(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle body = GoogleFonts.notoSans(
    color: AppColors.grey,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle heading40 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body20 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle body22 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}
