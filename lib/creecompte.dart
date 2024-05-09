import 'package:dentiste/dentiste/accueildentiste.dart';
import 'package:dentiste/patient/accceilpatient.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:dentiste/connecter_page.dart';

void main() {
  runApp(MaterialApp(
    home: CreerComptePage(),
  ));
}

class CreerComptePage extends StatefulWidget {
  @override
  _CreerComptePageState createState() => _CreerComptePageState();
}

class _CreerComptePageState extends State<CreerComptePage> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();
  final TextEditingController codeConfirmationController =
      TextEditingController();

  String? genreValue;
  String? roleValue;
  String? specialiteValue;

  Future<void> signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: motDePasseController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer votre compte'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: prenomController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: genreValue,
              decoration: InputDecoration(
                labelText: 'Genre',
                prefixIcon: Icon(Icons.people),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              items: <String>['Masculin', 'Féminin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  genreValue = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: telephoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                if (value.length == 9) {
                  setState(() {
                    telephoneController.text = '+213 ' + value;
                    telephoneController.selection = TextSelection.fromPosition(
                      TextPosition(offset: telephoneController.text.length),
                    );
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone (9 chiffres)',
                prefixIcon: Icon(Icons.phone),
                hintText: '*********',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: motDePasseController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choisissez votre rôle :',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Dentiste',
                      groupValue: roleValue,
                      onChanged: (value) {
                        setState(() {
                          roleValue = value;
                        });
                      },
                    ),
                    Text('Dentiste'),
                    SizedBox(width: 20),
                    Radio<String>(
                      value: 'Patient',
                      groupValue: roleValue,
                      onChanged: (value) {
                        setState(() {
                          roleValue = value;
                        });
                      },
                    ),
                    Text('Patient'),
                  ],
                ),
              ],
            ),
            // Ajout du champ de saisie de la spécialité pour le dentiste
            if (roleValue == 'Dentiste')
              DropdownButtonFormField<String>(
                value: specialiteValue,
                decoration: InputDecoration(
                  labelText: 'Spécialité',
                  prefixIcon: Icon(Icons.assignment_ind),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                items: <String>[
                  'Orthodontie',
                  'Parodontologie',
                  'Implantologie',
                  'Endodontie',
                  'Pédiatrie dentaire',
                  'Chirurgie buccale et maxillo-faciale',
                  'Dentisterie cosmétique',
                  // Ajoutez ici d'autres spécialités selon vos besoins
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    specialiteValue = value;
                  });
                },
              ),
            ElevatedButton(
              onPressed: () {
                verifierChamps(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Créer un compte',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                retournerVersTroisiemePage(context);
              },
              child: Text(
                'Vous avez déjà un compte ? Se connecter',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifierChamps(BuildContext context) {
    String nom = nomController.text;
    String prenom = prenomController.text;
    String telephone = telephoneController.text;
    String email = emailController.text;
    String motDePasse = motDePasseController.text;

    if (nom.isEmpty ||
        prenom.isEmpty ||
        telephone.isEmpty ||
        email.isEmpty ||
        motDePasse.isEmpty ||
        genreValue == null ||
        roleValue == null) {
      afficherMessageErreur(context, 'Veuillez remplir tous les champs.');
    } else if (telephone.length != 14) {
      afficherMessageErreur(
          context, 'Le numéro de téléphone doit contenir 9 chiffres.');
    } else {
      afficherDialogConfirmation(context);
    }
  }

  void afficherDialogConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Code de confirmation',
            style: TextStyle(color: Colors.blue),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Veuillez entrer le code de confirmation envoyé à votre numéro de téléphone :',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: codeConfirmationController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Code de confirmation (6 chiffres)',
                  fillColor: Colors.blue,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                verifierCodeConfirmation(context);
              },
              child: Text('Valider'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  void verifierCodeConfirmation(BuildContext context) {
    String codeConfirmation = codeConfirmationController.text;
    if (codeConfirmation.length != 6 ||
        int.tryParse(codeConfirmation) == null) {
      afficherMessageErreur(
          context, 'Le code de confirmation doit contenir 6 chiffres.');
    } else {
      creerCompte(context);
    }
  }

  Future<void> creerCompte(BuildContext context) async {
    await signUp();
    if (roleValue == 'Dentiste') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AccueildentistePage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AcceuilPatientPage(),
        ),
      );
    }
  }

  void afficherMessageErreur(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Erreur',
            style: TextStyle(color: Colors.blue),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.blue),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  void retournerVersTroisiemePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ConnecterPage()),
    );
  }
}
