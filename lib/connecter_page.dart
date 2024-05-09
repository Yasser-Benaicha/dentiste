import 'package:flutter/material.dart';
import 'patient/accceilpatient.dart';
import 'dentiste/accueildentiste.dart'; // Importez votre page de destination CinquiemePage.dart
import 'oblier_mdps.dart'; // Importez votre page de récupération de mot de passe OblierMdpsPage.dart

class ConnecterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();

  // Fonction pour vérifier si le nom d'utilisateur existe dans la base de données
  bool verifierUtilisateur(String email, String motDePasse) {
    // Vous pouvez ajouter ici la logique de vérification réelle
    // Par exemple, une vérification de base de données, une requête API, etc.
    if ((email == "admin" && motDePasse == "1234")) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Se connecter'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Bienvenue',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: motDePasseController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les valeurs des champs
                String email = emailController.text;
                String motDePasse = motDePasseController.text;

                // Vérifier si les champs ne sont pas vides
                if (email.isNotEmpty && motDePasse.isNotEmpty) {
                  // Vérifier l'utilisateur dans la base de données
                  if (verifierUtilisateur(email, motDePasse)) {
                    // Naviguer vers la CinquiemePage si la vérification est réussie
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AcceuilPatientPage()),
                    );
                  } else if ((email == "admin" && motDePasse == "456")) {
                    // Naviguer vers la page d'accueil du dentiste si la vérification est réussie
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccueildentistePage()),
                    );
                  } else {
                    // Afficher une erreur ou un message d'alerte si la vérification échoue
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Erreur"),
                          content: Text("Email ou mot de passe incorrect."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Afficher un message d'erreur si les champs sont vides
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erreur'),
                        content: Text('Veuillez remplir tous les champs'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'SE CONNECTER',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Aller à la page de récupération de mot de passe
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OblierMdpsPage()),
                );
              },
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
