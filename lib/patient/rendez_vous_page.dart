import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiste/model/dentiste_model.dart';
import 'package:dentiste/model/rendez_vous_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RendezVousPage extends StatefulWidget {
 dynamic dentiste;
 RendezVousPage(this.dentiste);
  @override
  _RendezVousPageState createState() => _RendezVousPageState();
}

class _RendezVousPageState extends State<RendezVousPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 8, minute: 0);
  Uuid uiid = Uuid();
  dynamic dentiste;
  FirebaseAuth currentUser=FirebaseAuth.instance;
  List<String> _buildAppointmentTimes() {
    List<String> times = [];
    for (int i = 8; i <= 11; i++) {
      times.add('${i.toString().padLeft(2, '0')}:00');
      times.add('${i.toString().padLeft(2, '0')}:30');
    }
    return times;
  }

  void _confirmAppointment() {
    // Afficher un message de remerciement
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Merci !'),
          content: Text('Votre rendez-vous est confirmé.'),
          actions: [
            TextButton(
              onPressed: () {
                // Retourner à la page précédente (AcceuilPatientPage)
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void createRendezVous(RendezVous rendezVous) async {
    CollectionReference _reference =
        FirebaseFirestore.instance.collection("RendezVous");
    await _reference.doc(rendezVous.id.toString()).set(rendezVous.toJson());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dentiste= widget.dentiste;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Prendre un rendez-vous chez le dentiste'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
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
                        'Dr. Mohamed Ahmed',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'General Dentistry ',
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
                  InkWell(
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            _selectedDate = date;
                          });
                        }
                      });
                    },
                    child: ListTile(
                      title: Text(
                        'Choisissez une date :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Choisissez une heure :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: DropdownButton(
                      value:
                          '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      items: _buildAppointmentTimes().map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedTime = TimeOfDay(
                            hour: int.parse(value!.split(':')[0]),
                            minute: int.parse(value.split(':')[1]),
                          );
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _confirmAppointment();
                      RendezVous rendezVous = RendezVous(
                        id: uiid.v4(),
                        date: DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute),
                        dentistesIds: [dentiste],
                        patientId: currentUser.currentUser!.uid,
                        motif: 'maladie dentaire',
                        state: 'En attente'
                      );
                      createRendezVous(rendezVous);
                    },
                    child: Text(
                      'Confirmer le rendez-vous',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
