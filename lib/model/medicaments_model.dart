class Medicaments {
  dynamic id;
  String? no;
  String? posologie;

  Medicaments(
      {this.id, this.no, this.posologie});
  Medicaments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    posologie = json['posologie'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no': no,
      'posologie': posologie,
    };
  }
}
