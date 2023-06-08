// import 'package:flutter/material.dart';
// import '../components/criterion.dart';
// import '../components/alternative.dart';
//
// class CriterionInherited extends InheritedWidget {
//   CriterionInherited({
//     Key? key,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   //Alternative a = new Alternative(name: "Acer", note: [1, 2, 3]);
//   //Alternative b = new Alternative(name: "Asus", note: [5, 6, 7]);
//
//   final List<Alternative> lista = [
//     Alternative(name: "Acer", note: [1, 2, 3]),
//     Alternative(name: "Asus", note: [5, 6, 7])
//   ];
//
//   void newAl (String name, List<int> int){
//     lista.add(Alternative(name: name, note: int));
//   }
//
//
//   //Map <String, dynamic> criteria = {};
//
//
//
//
//   static CriterionInherited of(BuildContext context) {
//     final CriterionInherited? result = context
//         .dependOnInheritedWidgetOfExactType<CriterionInherited>();
//     assert(result != null, 'No CriterionInherited found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(CriterionInherited old) {
//     return old.lista.length != lista.length;
//   }
// }
