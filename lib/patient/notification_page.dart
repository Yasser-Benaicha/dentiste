import 'package:flutter/material.dart';

class NotificationRendezVousPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue, // Couleur de l'app Bar en bleu
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Exemple de notification de rendez-vous accepté
            Card(
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.event_available,
                    color:
                        Colors.green), // Icône verte pour rendez-vous accepté
                title: Text(
                  'Rendez-vous accepté',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                    'Votre rendez-vous du 28 Mars 2024 à 10h est confirmé.'),
                onTap: () {
                  // Action à effectuer lorsque la notification est tapée
                  // Par exemple, afficher plus de détails sur le rendez-vous
                },
              ),
            ),
            SizedBox(height: 10), // Espace entre les cartes (10 pixels
                        // Exemple de notification de rendez-vous refusé
            Card(
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.event_busy,
                    color: Colors.red), // Icône rouge pour rendez-vous refusé
                title: Text(
                  'Rendez-vous refusé',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle:
                    Text('Votre rendez-vous du 30 Mars 2024 à 14h est annulé.'),
                onTap: () {
                  // Action à effectuer lorsque la notification est tapée
                  // Par exemple, afficher plus de détails sur le rendez-vous
                },
              ),
            ),
            // Vous pouvez ajouter plus de cartes pour d'autres notifications de rendez-vous
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationRendezVousPage(),
  ));
}
