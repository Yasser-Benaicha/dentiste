import 'package:flutter/material.dart';

class DossierMedicalPage extends StatelessWidget {
  // Exemple de liste d'historique des rendez-vous
  final List<Map<String, dynamic>> rendezVousList = [
    {
      'dentiste': 'Dr. ahemed ali ',
      'traitement': 'Extraction de dent',
      'medicament': 'Ibuprofène',
      'date': '2024-03-20',
      'heure': '09:30',
    },
    {
      'dentiste': 'Dr. mohamed amine',
      'traitement': 'Nettoyage dentaire',
      'medicament': 'Fluorure',
      'date': '2024-03-21',
      'heure': '10:00',
    },
    {
      'dentiste': 'Dr. ahemed ali ',
      'traitement': 'Extraction de dent',
      'medicament': 'Ibuprofène',
      'date': '2024-03-20',
      'heure': '09:30',
    },
    {
      'dentiste': 'Dr. mohamed amine',
      'traitement': 'Nettoyage dentaire',
      'medicament': 'Fluorure',
      'date': '2024-03-21',
      'heure': '10:00',
    },
    {
      'dentiste': 'Dr. ahemed ali ',
      'traitement': 'Extraction de dent',
      'medicament': 'Ibuprofène',
      'date': '2024-03-20',
      'heure': '09:30',
    },
    {
      'dentiste': 'Dr. mohamed amine',
      'traitement': 'Nettoyage dentaire',
      'medicament': 'Fluorure',
      'date': '2024-03-21',
      'heure': '10:00',
    },
    {
      'dentiste': 'Dr. ahemed ali ',
      'traitement': 'Extraction de dent',
      'medicament': 'Ibuprofène',
      'date': '2024-03-20',
      'heure': '09:30',
    },
    {
      'dentiste': 'Dr. mohamed amine',
      'traitement': 'Nettoyage dentaire',
      'medicament': 'Fluorure',
      'date': '2024-03-21',
      'heure': '10:00',
    },
    // Ajoutez d'autres rendez-vous ici selon votre besoin
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossier Médical'),
        backgroundColor: Colors.blue, // Couleur de la barre d'app Bar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/téléchargement.jpg'), // Chemin vers votre image de fond
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: rendezVousList.length,
          itemBuilder: (context, index) {
            final rendezVous = rendezVousList[index];
            return Card(
              color: Colors.blue, // Couleur de fond de chaque Card
              child: ListTile(
                title: Text('Dentiste: ${rendezVous['dentiste']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Traitement: ${rendezVous['traitement']}'),
                    Text('Médicament: ${rendezVous['medicament']}'),
                    Text('Date: ${rendezVous['date']}'),
                    Text('Heure: ${rendezVous['heure']}'),
                  ],
                ),
                onTap: () {
                  // Action à effectuer lorsqu'un rendez-vous est tapé
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Détails du Rendez-vous'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Dentiste: ${rendezVous['dentiste']}'),
                          Text('Traitement: ${rendezVous['traitement']}'),
                          Text('Médicament: ${rendezVous['medicament']}'),
                          Text('Date: ${rendezVous['date']}'),
                          Text('Heure: ${rendezVous['heure']}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Fermer'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
