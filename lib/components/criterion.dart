import 'alternative.dart';

class Criterion {
  String criterionName;
  double weight;
  List<Alternative> alternatives;

  Criterion({
    required this.criterionName,
    required this.weight,
    required this.alternatives,
  });

  factory Criterion.fromMap(Map<String, dynamic> json) => Criterion(
    criterionName: json["criterion_name"],
    weight: json["weight"]?.toDouble(),
    alternatives: List<Alternative>.from(
        json["alternatives"].map((x) => Alternative.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "criterion_name": criterionName,
    "weight": weight,
    "alternatives": List<dynamic>.from(alternatives.map((x) => x.toMap())),
  };
}