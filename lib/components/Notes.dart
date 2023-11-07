class Notes {
  String notaMenor = "";
  String notaMDia = "";
  String notaMaior = "";

  Notes({required this.notaMenor, required this.notaMDia, required this.notaMaior});

  Notes.fromJson(Map<String, dynamic> json) {
    notaMenor = json['notaMenor'];
    notaMDia = json['notaMédia'];
    notaMaior = json['notaMaior'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notaMenor'] = this.notaMenor;
    data['notaMédia'] = this.notaMDia;
    data['notaMaior'] = this.notaMaior;
    return data;
  }

  String add(String menor, String media, String maior){
    this.notaMenor = menor;
    this.notaMDia = media;
    this.notaMaior = maior;

    return "Inserido";
  }
}