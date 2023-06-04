import 'package:flutter/material.dart';
import 'character.dart';
import 'character_details_screen.dart';

class SavedCharactersScreen extends StatelessWidget {
  final List<Character> savedCharacters;

  SavedCharactersScreen({required this.savedCharacters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personaggi salvati'),
      ),
      body: ListView.builder(
        itemCount: savedCharacters.length,
        itemBuilder: (context, index) {
          Character character = savedCharacters[index];
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(character.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Classe: ${character.characterClass.name}'),
                Text('Razza: ${character.characterRace.name}'),
              ],
            ),
            onTap: () {
              navigateToCharacterDetails(context, character);
            },
          );
        },
      ),
    );
  }

  void navigateToCharacterDetails(BuildContext context, Character character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailsScreen(
          character: character,
          onDelete: () {},
        ),
      ),
    );
  }
}
