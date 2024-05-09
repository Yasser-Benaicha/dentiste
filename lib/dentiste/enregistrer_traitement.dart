import 'package:flutter/material.dart';

class ListeMedicamentsTraitements extends StatefulWidget {
  @override
  _ListeMedicamentsTraitementsState createState() =>
      _ListeMedicamentsTraitementsState();
}

class _ListeMedicamentsTraitementsState
    extends State<ListeMedicamentsTraitements> {
  // Listes des médicaments et traitements
  List<String> listeMedicaments = ['Paracétamol', 'Ibuprofène'];
  List<String> listeTraitements = ['Détartrage', 'Extraction dentaire'];

  TextEditingController nomController = TextEditingController();
  String? selectionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste Médicaments & Traitements'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(),
            Text('Médicaments', textAlign: TextAlign.center),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listeMedicaments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listeMedicaments[index]),
                  onTap: () {
                    _supprimerMedicamentOuTraitement(
                        context, 'Médicament', index);
                  },
                );
              },
            ),
            Divider(),
            Text('Traitements', textAlign: TextAlign.center),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listeTraitements.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listeTraitements[index]),
                  onTap: () {
                    _supprimerMedicamentOuTraitement(
                        context, 'Traitement', index);
                  },
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _ajouterMedicamentOuTraitement(context);
              },
              child: Text('Ajouter Médicament ou Traitement'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Fonction pour supprimer un médicament ou traitement
  void _supprimerMedicamentOuTraitement(
      BuildContext context, String type, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Supprimer $type'),
          content: Text('Voulez-vous vraiment supprimer ce $type ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (type == 'Médicament') {
                  setState(() {
                    listeMedicaments.removeAt(index);
                  });
                } else if (type == 'Traitement') {
                  setState(() {
                    listeTraitements.removeAt(index);
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Confirmer'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour ajouter un nouveau médicament ou traitement
  void _ajouterMedicamentOuTraitement(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ajouter Médicament ou Traitement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectionType,
                hint: Text('Sélectionner le type'),
                onChanged: (value) {
                  setState(() {
                    selectionType = value;
                  });
                },
                items: ['Médicament', 'Traitement'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                    labelText: 'Nom du Médicament ou Traitement'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String nom = nomController.text;
                if (selectionType == 'Médicament') {
                  setState(() {
                    listeMedicaments.add(nom);
                  });
                } else if (selectionType == 'Traitement') {
                  setState(() {
                    listeTraitements.add(nom);
                  });
                }
                nomController.clear();
                selectionType = null;
                Navigator.pop(context);
              },
              child: Text('Ajouter'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListeMedicamentsTraitements(),
  ));
}
