import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/rendez_vous_model.dart';

class NotificationRendezVousPage extends StatefulWidget {
  @override
  State<NotificationRendezVousPage> createState() =>
      _NotificationRendezVousPageState();
}

class _NotificationRendezVousPageState
    extends State<NotificationRendezVousPage> {
  List<RendezVous> _rendezVous = [];
    FirebaseAuth currentUser=FirebaseAuth.instance;
  bool loading = true;

  Future<void> getRendezVousList() async {
    loading=true;
    _rendezVous = <RendezVous>[];
    RendezVous test = RendezVous(state: 'En Attente');
    final CollectionReference _reference =
        await FirebaseFirestore.instance.collection("RendezVous");
    try {
      QuerySnapshot querySnapshot = await _reference.get();
      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          test = RendezVous.fromJson(data);
          if (test.patientId==currentUser.currentUser!.uid) {
            _rendezVous.add(test);
          }
          
        }
      });
    } catch (e) {
      print("Error fetching Dentistes: $e");
    }
    loading=false;
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRendezVousList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue, // Couleur de l'app Bar en bleu
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: loading
            ? CircularProgressIndicator()
            :
                    ListView.builder(
                      itemCount: _rendezVous.length,
                      itemBuilder:(context, index) => Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.event_available,
          color: _rendezVous[index].state=="Accepter"?
              Colors.green:_rendezVous[index].state=="Refuser"?Colors.red:Colors.yellow), // Icône verte pour rendez-vous accepté
                        title: Text(
        _rendezVous[index].state,
        style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
          'Votre rendez-vous ${_rendezVous[index].id} est confirmé.'),
                        onTap: () {
        // Action à effectuer lorsque la notification est tapée
        // Par exemple, afficher plus de détails sur le rendez-vous
                        },
                      ),
                    ),),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationRendezVousPage(),
  ));
}
