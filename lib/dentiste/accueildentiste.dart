import 'package:dentiste/dentiste/dossier_page.dart';
import 'package:dentiste/dentiste/enregistrer_traitement.dart';
import 'package:dentiste/dentiste/profiledentiste_page.dart';
import 'package:flutter/material.dart';

class AccueildentistePage extends StatefulWidget {
  AccueildentistePage();

  @override
  _AccueildentistePageState createState() => _AccueildentistePageState();
}

class _AccueildentistePageState extends State<AccueildentistePage> {
  final List<Patient> _Patient = [
    Patient(
        nom: 'MR. Mohamed',
        prenom: 'Ahmed',
        rendezvous: '12/05/2024 a 10h00',
        image: 'assets/profiluh.png'),
    Patient(
        nom: 'MD Fatima',
        prenom: 'Ali',
        rendezvous: '12/05/2024 a 10h00',
        image: 'assets/profiluf.png'),
    Patient(
        nom: 'MD Fatima',
        prenom: 'Ali',
        rendezvous: '12/05/2024 a 10h00',
        image: 'assets/profiluh.png'),
    Patient(
        nom: 'MR. Mohamed',
        prenom: 'Ahmed',
        rendezvous: '12/05/2024 a 10h00',
        image: 'assets/profiluh.png'),
    Patient(
        nom: 'MD Fatima',
        prenom: 'Ali',
        rendezvous: '12/05/2024 a 10h00',
        image: 'assets/profiluf.png'),
    Patient(
        nom: 'MD Fatima',
        prenom: 'Ali',
        rendezvous: '12/05/2024 a 10h00',
        image: 'assets/profiluh.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Ajout de l'espace en haut
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profildrh.png'),
                  radius: 30,
                ),
                SizedBox(
                  width: 10,
                  height: 75,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BIENVENUE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(
                      'Dr Ahmed ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(
                      'Dentiste',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _Patient.length,
              itemBuilder: (context, index) {
                final dentist = _Patient[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(dentist.image),
                    backgroundColor:
                        Colors.white, // White background for avatar
                  ),
                  title: Text('${dentist.nom} ${dentist.prenom}',
                      style: TextStyle(color: Colors.blue[700])),
                  subtitle: Text(dentist.rendezvous,
                      style: TextStyle(color: Colors.grey[600])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Code pour accepter le rendez-vous
                        },
                        child: Text('Accepter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Code pour annuler le rendez-vous
                        },
                        child: Text('Annuler'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[700], // Changement de la couleur de fond
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.folder, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DossierpatientPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.local_pharmacy, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListeMedicamentsTraitements()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            nom: 'Mohamed',
                            prenom: 'Ahmed',
                            specialite: 'Dentiste',
                            email: 'ahmedmohamed@gmail',
                            telephone: '+21344777777',
                            genre: 'Masculin',
                            image: 'assets/1.png',
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Patient {
  final String nom;
  final String prenom;
  final String rendezvous;
  final String image;

  Patient(
      {required this.nom,
      required this.prenom,
      required this.rendezvous,
      required this.image});
}

void main() {
  runApp(MaterialApp(
    home: AccueildentistePage(),
  ));
}
