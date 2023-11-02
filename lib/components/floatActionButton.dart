import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/components/showDialog.dart';

FloatingActionButton wFloatActionButton(context, labelTitle, text,
    numberOfAlternatives, createInputAlt, increment, qnt) {
  return FloatingActionButton(
    elevation: 10,
    backgroundColor: AppColors.deepSkyBlue,
    onPressed: () {
      if (numberOfAlternatives < qnt) {
        createInputAlt(context);
        increment();
        // numberOfAlternatives++; // Incrementa o contador de alternativas
      } else {
        // Mostra um aviso quando o limite é atingido
        wShowDialog(context, labelTitle, text);
      }
      print(numberOfAlternatives);
    },
    tooltip: 'Adicionar',
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: AppColors.deepSkyBlue),
    ),
    child: const Icon(Icons.add),
  );
}
