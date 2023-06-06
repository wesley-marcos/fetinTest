import 'package:flutter/material.dart';
import 'alternative.dart';

class Alternatives extends ChangeNotifier {
  List<Alternative> alternatives;

  Alternatives({required this.alternatives});

  void add(Alternative alt){
    alternatives.add(alt);
    notifyListeners();
  }

  void remove(int index){
    alternatives.remove(index);
    notifyListeners();
  }
}