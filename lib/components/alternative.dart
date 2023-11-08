class Alternative {
  String name;
  List<int> note;

  Alternative({
    required this.name,
    required this.note,
  });

  factory Alternative.fromMap(Map<String, dynamic> json) => Alternative(
        name: json["name"],
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "note": note,
      };
}
