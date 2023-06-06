import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criterion.dart';

class Criteria extends ChangeNotifier {
  List<Criterion> criteria;

  Criteria({required this.criteria});

  void add(String nome, double peso, List<Alternative> alternativas) {
    criteria.add(Criterion(
        criterionName: nome,
        weight: peso,
        alternatives: alternativas
    ));
    notifyListeners();
  }

  void remove(int index) {
    criteria.remove(index);
    notifyListeners();
  }
}
