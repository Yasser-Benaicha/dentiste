class Traitement {
  dynamic id;
  DateTime? date;
  String? description;
  dynamic dentisteId;
  dynamic patientId;

  Traitement(
      {this.id, this.date, this.description, this.dentisteId, this.patientId});
  Traitement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    description = json['description'];
    dentisteId = json['dentisteId'];
    patientId = json['patientId'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'dentisteId': dentisteId,
      'patientId': patientId
    };
  }
}
