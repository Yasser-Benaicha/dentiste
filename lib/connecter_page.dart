import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/patient_model.dart';
import 'patient/accceilpatient.dart';
import 'dentiste/accueildentiste.dart'; // Importez votre page de destination CinquiemePage.dart
import 'oblier_mdps.dart'; // Importez votre page de récupération de mot de passe OblierMdpsPage.dart

class ConnecterPage extends StatefulWidget {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  @override
  State<ConnecterPage> createState() => _ConnecterPageState();
}

class _ConnecterPageState extends State<ConnecterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool verification = false;
  PatientModel patient = PatientModel();

  connecter(BuildContext context) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: motDePasseController.text,
      );
      // Authentication was successful
      print('Authentication successful for user: ${authResult.user!.email}');
      // Set verification to true since authentication was successful
      if (authResult.user != null) {
        setState(() {
          verification = true;
        });
        patient = PatientModel();
        final DocumentReference _reference = await FirebaseFirestore.instance
            .collection("Patients")
            .doc(authResult.user!.uid);
        print("User ID " + authResult.user!.uid);
        DocumentSnapshot<Object?> querySnapshot = await _reference.get();
        if (querySnapshot.exists) {
          patient = PatientModel.fromJson(
              querySnapshot.data() as Map<String, dynamic>);
        }
      }
      print(verification);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      String errorMessage = 'An error occurred, please try again.';
      // Customize error message based on error code
      if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Authentication Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      // Set verification to false since authentication failed
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
              onPressed: () async {
                // Récupérer les valeurs des champs
                String email = emailController.text;
                String motDePasse = motDePasseController.text;

                // Vérifier si les champs ne sont pas vides
                if (email.isNotEmpty && motDePasse.isNotEmpty) {
                  // Vérifier l'utilisateur dans la base de données
                  await connecter(context);
                  if (verification == true) {
                    // Naviguer vers la CinquiemePage si la vérification est réussie
                    ConnecterPage.instance.setString('Token', motDePasse);
                    patient != PatientModel()
                        ? ConnecterPage.instance.setString('Role', "Patients")
                        : ConnecterPage.instance.setString('Role', "Dentistes");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => patient != PatientModel()
                              ? AcceuilPatientPage()
                              : AccueildentistePage()),
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
