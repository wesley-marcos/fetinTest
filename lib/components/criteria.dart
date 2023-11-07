import 'package:flutter/material.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criterion.dart';
import 'dart:convert';

class Criteria extends ChangeNotifier {
  List<Criterion> criteria;
  List<String> alternativeNames;

  List<Alternative> alternatives = [];

  Criteria({required this.criteria, required this.alternativeNames});

  // Método para converter a lista de critérios em JSON
  String toJson() {
    List<Map<String, dynamic>> criteriaList = criteria.map((criterion) {
      return {
        'criterionName': criterion.criterionName,
        'weight': criterion.weight,
        'alternatives': criterion.alternatives.map((alternative) {
          return {
            'name': alternative.name,
            'note': alternative.note,
          };
        }).toList(),
      };
    }).toList();

    Map<String, dynamic> criteriaJson = {
      'criteria': criteriaList,
    };

    return json.encode(criteriaJson);
  }

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

  // void updateAlternativeNote(String alternativeName, int note) {
  //   for (var alternative in alternatives) {
  //     if (alternative.name == alternativeName) {
  //       alternative.note = note[alternative];
  //       break;
  //     }
  //   }
  //   notifyListeners();
  // }

  void reset() {
    for(var i in criteria){
      if(criteria.isNotEmpty)
        criteria.remove(i);
    }

    for(var i in alternativeNames){
      if(alternativeNames.isNotEmpty)
        alternativeNames.remove(i);
    }
  }
}
