import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiste/model/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:dentiste/patient/notification_page.dart';
import 'package:dentiste/patient/profilpatient_page.dart';
import 'package:dentiste/patient/dossier_medical_page.dart';

import '../model/dentiste_model.dart';
import '../model/rendez_vous_model.dart';
import 'rendez_vous_page.dart';

class AcceuilPatientPage extends StatefulWidget {
  @override
  _AcceuilPatientPageState createState() => _AcceuilPatientPageState();
}

class _AcceuilPatientPageState extends State<AcceuilPatientPage> {
  List<Dentiste> _dentists = [];
  List<Dentiste> _filteredDentists = [];
  bool loading = true;
  Future<void> getDensitesList() async {
    loading = true;
    _dentists = <Dentiste>[];
    final CollectionReference _reference =
        await FirebaseFirestore.instance.collection("Dentistes");
    try {
      QuerySnapshot querySnapshot = await _reference.get();
      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          _dentists.add(Dentiste.fromJson(data));
        }
      });
    } catch (e) {
      print("Error fetching Dentistes: $e");
    }
    _filteredDentists.addAll(_dentists);
    print(_filteredDentists.length);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDensitesList();
  }

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    backgroundImage: AssetImage('assets/profiluh.png'),
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
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'Ahmed Amine ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
              child: Column(
                children: [
                  Text(
                    'Dentists',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      filterDentists(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Rechercher un dentiste',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  loading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                        physics:BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _filteredDentists.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage(_filteredDentists[index].image??'assets/profil.png'),
                              ),
                              title: Text(
                                  '${_filteredDentists[index].nom} ${_filteredDentists[index].prenom}'),
                              subtitle:
                                  Text(_filteredDentists[index].specialite!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RendezVousPage(_filteredDentists[index].id)),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.history, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DossierMedicalPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationRendezVousPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilpatientPage(
                            nom: 'akram',
                            prenom: 'bchnf',
                            genre: 'Masculin',
                            telephone: '2138888888',
                            email: 'akram@gmail.com',
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void filterDentists(String query) {
    _filteredDentists.clear();
    if (query.isNotEmpty) {
      List<Dentiste> filteredList = [];
      _dentists.forEach((dentist) {
        if (dentist.nom!.toLowerCase().contains(query.toLowerCase()) ||
            dentist.prenom!.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(dentist);
        }
      });
      setState(() {
        _filteredDentists.addAll(filteredList);
      });
      return;
    } else {
      setState(() {
        _filteredDentists.addAll(_dentists);
      });
    }
  }
}

class Dentist {
  final String nom;
  final String prenom;
  final String specialite;
  final String image;

  Dentist(
      {required this.nom,
      required this.prenom,
      required this.specialite,
      required this.image});
}
