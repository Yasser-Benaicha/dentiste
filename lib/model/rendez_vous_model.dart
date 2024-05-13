class RendezVous {
  dynamic id;
  dynamic date;
  List<dynamic>? dentistesIds = [];
  dynamic patientId;
  String? motif;
  String state='En attente';

  RendezVous({this.id, this.date, this.dentistesIds, this.patientId, this.motif, required this.state});
  RendezVous.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dentistesIds = json['dentistesIds'];
    patientId = json['patient'];
    motif = json['motif'];
    state= json['state'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'dentistesIds': dentistesIds,
      'patient': patientId,
      'motif': motif,
      'state':state
    };
  }
}
