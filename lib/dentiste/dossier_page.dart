import 'package:flutter/material.dart';

// Modèle de Données Patient
class Patient {
  final String nom;
  final String prenom;
  final String rendezvous;
  Image? image;
  String? traitement;
  String? medicament;

  Patient({
    required this.nom,
    required this.prenom,
    required this.rendezvous,
    this.traitement,
    this.medicament,
    required Image image,
  });
}

class DossierpatientPage extends StatefulWidget {
  @override
  _DossierpatientPageState createState() => _DossierpatientPageState();
}

class _DossierpatientPageState extends State<DossierpatientPage> {
  final List<Patient> _patients = [
    Patient(
      nom: 'MR. Mohamed',
      prenom: 'Ahmed',
      image: Image.asset('assets/profiluh.png'),
      rendezvous: '12/05/2024 à 10h00',
    ),
    Patient(
      nom: 'MD Fatima',
      prenom: 'Ali',
      image: Image.asset('assets/profiluf.png'),
      rendezvous: '12/05/2024 à 11h00',
    ),
    Patient(
      nom: 'MD Fatima',
      prenom: 'Ali',
      image: Image.asset('assets/profiluh.png'),
      rendezvous: '12/05/2024 à 12h00',
    ),
    Patient(
      nom: 'MR. Mohamed',
      prenom: 'Ahmed',
      image: Image.asset('assets/profiluh.png'),
      rendezvous: '12/05/2024 à 10h00',
    ),
    Patient(
      nom: 'MD Fatima',
      prenom: 'Ali',
      image: Image.asset('assets/profiluf.png'),
      rendezvous: '12/05/2024 à 11h00',
    ),
    Patient(
      nom: 'MD Fatima',
      prenom: 'Ali',
      image: Image.asset('assets/profiluh.png'),
      rendezvous: '12/05/2024 à 12h00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossier Patient'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: Colors.blue[50],
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
            title: Text(
              '${_patients[index].nom} ${_patients[index].prenom}',
              style: TextStyle(color: Colors.blue),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rendez-vous: ${_patients[index].rendezvous}',
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(height: 4),
                if (_patients[index].medicament != null &&
                    _patients[index].traitement != null)
                  Text(
                    'Médicament: ${_patients[index].medicament}',
                    style: TextStyle(color: Colors.blue),
                  ),
                if (_patients[index].medicament != null &&
                    _patients[index].traitement != null)
                  Text(
                    'Traitement: ${_patients[index].traitement}',
                    style: TextStyle(color: Colors.blue),
                  ),
              ],
            ),
            onTap: () {
              _ajouterTraitementEtMedicament(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _rechercherPatient();
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _ajouterTraitementEtMedicament(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String traitement = "";
        String medicament = "";

        return AlertDialog(
          title: Text('Ajouter Traitement et Médicament'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Traitement'),
                  onChanged: (value) {
                    traitement = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Médicament'),
                  onChanged: (value) {
                    medicament = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _patients[index].traitement = traitement;
                  _patients[index].medicament = medicament;
                });
                Navigator.of(context).pop();
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _rechercherPatient() {
    // Implémentez la logique de recherche du patient ici
  }
}
