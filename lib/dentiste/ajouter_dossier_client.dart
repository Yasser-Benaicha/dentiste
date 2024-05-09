import 'package:flutter/material.dart';
import 'package:dentiste/dentiste/enregistrer_traitement.dart';

class AjouterDossierClient extends StatefulWidget {
  @override
  _AjouterDossierClientState createState() => _AjouterDossierClientState();
}

class _AjouterDossierClientState extends State<AjouterDossierClient> {
  String? selectedTraitement;
  String? selectedMedicament;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Dossier Client'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom du client :'),
            TextFormField(),
            SizedBox(height: 10.0),
            Text('Prénom du client :'),
            TextFormField(),
            SizedBox(height: 10.0),
            Text('Date de naissance :'),
            TextFormField(),
            SizedBox(height: 10.0),
            Text('Traitement :'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListeMedicamentsTraitements(),
                  ),
                );
              },
              child: Text(selectedTraitement ?? 'Sélectionner un Traitement'),
            ),
            SizedBox(height: 10.0),
            Text('Médicaments :'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListeMedicamentsTraitements(),
                  ),
                );
              },
              child: Text(selectedMedicament ?? 'Sélectionner un Médicament'),
            ),
            SizedBox(height: 10.0),
            Text('Recherche un patient :'),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Entrez le nom, le prénom ou le numéro de téléphone',
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Enregistrer les données du formulaire
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
