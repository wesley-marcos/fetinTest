import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';

Padding wButtonProximo(context, titleLabel, text, tela, isLoading, condition) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 17.0, left: 50, right: 50),
    child: isLoading // Verificar se o loading está ativo
        ? const CircularProgressIndicator() // Exibir o loading
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepSkyBlue,
              elevation: 10,
              fixedSize: const Size(200, 53),
              side: const BorderSide(color: AppColors.deepSkyBlue),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(10))),
            ),
            onPressed: condition,
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
