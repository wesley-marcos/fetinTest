import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criterion.dart';

class Criteria extends ChangeNotifier {
  List<Criterion> criteria;
  List<String> alternativeNames;

  List<Alternative> alternatives = [];

  Criteria({required this.criteria, required this.alternativeNames});

  void add(String nome, double peso, List<Alternative> alternativas) {
    criteria.add(Criterion(
        criterionName: nome, weight: peso, alternatives: alternativas));
    notifyListeners();
  }

  void remove(int index) {
    criteria.remove(index);
    notifyListeners();
  }

  void addName(String nome) {
    alternativeNames.add(nome);
    notifyListeners();
  }

  void updateAlternativeNote(String alternativeName, int note) {
    for (var alternative in alternatives) {
      if (alternative.name == alternativeName) {
        alternative.note = note;
        break;
      }
    }
    notifyListeners();
  }
}
