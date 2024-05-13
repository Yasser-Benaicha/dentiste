class PatientModel {
  String? id;
  String? nom, prenom, adresse, email, telephone, genre, image,role;
  List<dynamic>? traitements = [];
  List<dynamic>? medicamentsPrescrits = [];
  List<dynamic>? rendezVousIds = [];

  PatientModel(
      {this.id,
      this.nom,
      this.prenom,
      this.adresse,
      this.email,
      this.telephone,
      this.genre,
      this.image,
      this.traitements,
      this.medicamentsPrescrits,
      this.rendezVousIds,
      this.role});
  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    adresse = json['adresse'];
    email = json['email'];
    telephone = json['telephone'];
    genre = json['genre'];
    traitements = json['traitements'];
    medicamentsPrescrits = json['medicamentsPrescrits'];
    rendezVousIds = json['rendezVous'];
    image = json['image'];
    role= json['role'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'adresse': adresse,
      'email': email,
      'telephone': telephone,
      'genre': genre,
      'traitement': traitements,
      'medicamentsPrescrits': medicamentsPrescrits,
      'rendezVous': rendezVousIds,
      'image':image,
      'role': role
    };
  }
}
