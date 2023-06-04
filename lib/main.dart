import 'package:flutter/material.dart';
import 'character_creator_screen.dart';

void main() => runApp(CharacterCreatorApp());

class CharacterCreatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creatore Personaggi D&D ',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        hintColor: Colors.amber,
        fontFamily: 'MedievalSharp',
      ),
      debugShowCheckedModeBanner: false,
      home: CharacterCreatorScreen(),
    );
  }
}
