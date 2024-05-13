class Dentiste {
  dynamic id;
  String? nom, prenom, specialite,image;
  List<dynamic>? rendezVousIds = [];

  Dentiste({this.id, this.nom, this.prenom,this.image, this.specialite,this.rendezVousIds});
  Dentiste.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    image = json['image'];
    specialite = json['specialite'];
    rendezVousIds = json['rendezVousIds'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'image':image,
      'specialite': specialite,
      'rendezVousIds': rendezVousIds
    };
  }
}
