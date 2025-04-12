import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyAppA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Recette Défilable'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Titre de la section des ingrédients
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Ingrédients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
            
                // Liste des ingrédients
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('1 tasse de farine'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('2 œufs'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('1/2 tasse de lait'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('1 pincée de sel'),
            
                ),
            
                // Titre de la section des instructions
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
            
                // Liste des instructions
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('Mélangez les ingrédients secs dans un grand bol.'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('1/2 tasse de lait'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('1 pincée de sel'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('Ajoutez les œufs et le lait, puis mélangez bien.'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('Faites cuire la pâte dans une poêle chaude jusqu\'à ce qu\'elle soit dorée.'),
            
                ),
                ListTile(
                  leading: Icon(Icons.circle, size: 10),
                  title: Text('Servez avec votre garniture préférée.'),
            
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
