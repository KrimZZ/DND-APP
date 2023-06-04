import 'package:flutter/material.dart';
import 'character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  final VoidCallback onDelete;

  CharacterDetailsScreen({required this.character, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettagli personaggio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${character.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Classe: ${character.characterClass.name}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Razza: ${character.characterRace.name}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onDelete,
              child: Text('Elimina personaggio'),
            ),
          ],
        ),
      ),
    );
  }
}
