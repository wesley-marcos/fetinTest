class Alternative {
  String name;
  List<int> note;

  Alternative({
    required this.name,
    required this.note,
  });

  factory Alternative.fromMap(Map<String, dynamic> json) => Alternative(
    name: json["name"],
    note: List<int>.from(json["note"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "note": List<dynamic>.from(note.map((x) => x)),
  };
}