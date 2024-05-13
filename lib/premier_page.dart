import 'package:flutter/material.dart';
import 'connecter_page.dart'; // Importer la classe de la troisième page
import 'creecompte.dart'; // Importer la classe de la quatrième page

class PremierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2196F3),
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 213, 237, 255),
                image: DecorationImage(
                  image: AssetImage('assets/dent.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Bienvenue chez dentiste',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Voulez-vous de l aide pour votre santé pour avoir une vie meilleure ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Naviguer vers la Troisième Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreerComptePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 213, 236, 255),
                  ),
                  child: Text(
                    "CREE UN COMPTE ",
                    style: TextStyle(
                      color: Colors.black, // Couleur du texte en noir
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Naviguer vers la Quatrième Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConnecterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 213, 236, 255),
                  ),
                  child: Text(
                    'SE CONNECTER',
                    style: TextStyle(
                      color: Colors.black, // Couleur du texte en noir
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
