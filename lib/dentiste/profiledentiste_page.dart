import 'package:dentiste/premier_page.dart';
import 'package:flutter/material.dart';
// Import de la AccueilPage

class ProfilePage extends StatelessWidget {
  final String nom;
  final String prenom;
  final String genre; // Ajout du genre de l'utilisateur
  final String specialite;
  final String telephone;
  final String email; // Ajout du genre de l'utilisateur

  ProfilePage({
    required this.nom,
    required this.prenom,
    required this.genre, // Initialiser le genre dans le constructeur
    required this.specialite,
    required this.telephone,
    required this.email,
    required String image, // Initialiser le genre dans le constructeur
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.blue, // Couleur de l'app Bar en bleu
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profildrh.png'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Dr $nom $prenom ',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person,
                            color: Colors.blue), // Icône bleu pour le nom
                        title: Text(
                          'Nom: $nom',
                          style: TextStyle(
                              color: Colors.black), // Texte noir pour le nom
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person,
                            color: Colors.blue), // Icône bleu pour le prénom
                        title: Text(
                          'Prénom: $prenom',
                          style: TextStyle(
                              color: Colors.black), // Texte noir pour le prénom
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person_outline,
                            color: Colors.blue), // Icône bleu pour le genre
                        title: Text(
                          'Genre: $genre',
                          style: TextStyle(
                              color: Colors.black), // Texte noir pour le genre
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person_outline,
                            color: Colors.blue), // Icône bleu pour le téléphone
                        title: Text(
                          'specialite: $specialite',
                          style: TextStyle(
                              color:
                                  Colors.black), // Texte noir pour le téléphone
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone,
                            color: Colors.blue), // Icône bleu pour le téléphone
                        title: Text(
                          'Téléphone: $telephone',
                          style: TextStyle(
                              color:
                                  Colors.black), // Texte noir pour le téléphone
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.email,
                            color: Colors.blue), // Icône bleu pour l'email
                        title: Text(
                          'Email: $email',
                          style: TextStyle(
                              color: Colors.black), // Texte noir pour l'email
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lorsque le bouton est pressé (Déconnexion)
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PremierPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Déconnexion',
                    style: TextStyle(
                        color: Colors.white)), // Texte blanc pour le bouton
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue, // Couleur de fond bleu pour le bouton
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
