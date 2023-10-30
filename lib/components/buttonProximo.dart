import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/components/showDialog.dart';
import 'package:hash_test/screens/home.dart';
import 'package:provider/provider.dart';

Padding wButtonProximo(context, titleLabel, text, tela) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 17.0, left: 50, right: 50),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepSkyBlue,
        elevation: 10,
        fixedSize: const Size(200, 53),
        side: const BorderSide(color: AppColors.deepSkyBlue),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
      ),
      onPressed: () {
        // Validar se há pelo menos 2 alternativas
        if (Provider.of<Criteria>(context, listen: false)
                .alternativeNames
                .length <
            2) {
          wShowDialog(
            context,
            "$titleLabel",
            "$text",
          );
        } else {
          // Navegar para a próxima tela
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => tela),
          );
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Próximo",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
