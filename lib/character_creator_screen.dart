import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'menu_items.dart';

class CharacterClass {
  final String name;
  final String description;

  CharacterClass({required this.name, required this.description});
}

class CharacterRace {
  final String name;
  final String description;

  CharacterRace({required this.name, required this.description});
}

class Character {
  final String name;
  final CharacterClass characterClass;
  final CharacterRace characterRace;
  final int age;

  Character({
    required this.name,
    required this.characterClass,
    required this.characterRace,
    required this.age,
  });
}

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  CharacterDetailsScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${character.name}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Age: ${character.age}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Class: ${character.characterClass.name}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Description: ${character.characterClass.description}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Race: ${character.characterRace.name}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Description: ${character.characterRace.description}',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

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
        builder: (context) => CharacterDetailsScreen(character: character),
      ),
    );
  }
}

class CharacterCreatorScreen extends StatefulWidget {
  @override
  _CharacterCreatorScreenState createState() => _CharacterCreatorScreenState();
}

class _CharacterCreatorScreenState extends State<CharacterCreatorScreen> {
  String characterName = '';
  int? characterAge;
  CharacterClass? characterClass;
  CharacterRace? characterRace;
  String? characterImage;

  List<CharacterClass> availableClasses = [];
  List<CharacterRace> availableRaces = [];

  List<Character> savedCharacters = [];

  @override
  void initState() {
    super.initState();
    loadClassesAndRaces();
  }

  void loadClassesAndRaces() async {
    String classesJson = await rootBundle.loadString('assets/json/ClassesRace.json');
    List<dynamic> classesData = json.decode(classesJson)['classes'];
    List<dynamic> racesData = json.decode(classesJson)['races'];

    availableClasses = classesData.map((classData) {
      return CharacterClass(
        name: classData['name'],
        description: classData['description'],
      );
    }).toList();

    availableRaces = racesData.map((raceData) {
      return CharacterRace(
        name: raceData['name'],
        description: raceData['description'],
      );
    }).toList();

    setState(() {
      // Update the state to reflect the loaded classes and races
    });
  }

  void setCharacterName(String name) {
    setState(() {
      characterName = name;
    });
  }

  void setCharacterAge(String age) {
    setState(() {
      characterAge = int.tryParse(age);
    });
  }

  void setCharacterClass(CharacterClass? selectedClass) {
    setState(() {
      characterClass = selectedClass;
    });
  }

  void setCharacterRace(CharacterRace? selectedRace) {
    setState(() {
      characterRace = selectedRace;
    });
  }

  void setCharacterImage(String? imagePath) {
    setState(() {
      characterImage = imagePath;
    });
  }

  void saveCharacter() {
    if (characterName.isNotEmpty && characterClass != null && characterRace != null && characterAge != null) {
      Character character = Character(
        name: characterName,
        characterClass: characterClass!,
        characterRace: characterRace!,
        age: characterAge!,
      );

      setState(() {
        savedCharacters.add(character);
      });

      print('Character saved!');
      navigateToCharacterDetails(character);
    }
  }

  void navigateToCharacterDetails(Character character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailsScreen(character: character),
      ),
    );
  }

  void navigateToSavedCharacters() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedCharactersScreen(savedCharacters: savedCharacters),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> menuItems = MenuItems.getMenuItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('D&D Character Creator'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: navigateToSavedCharacters,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (var menuItem in menuItems)
              ListTile(
                title: Text(menuItem.title),
                onTap: menuItem.onTap,
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: setCharacterName,
                decoration: InputDecoration(
                  labelText: 'Character Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: setCharacterAge,
                decoration: InputDecoration(
                  labelText: 'Character Age',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<CharacterClass>(
                value: characterClass,
                onChanged: setCharacterClass,
                items: availableClasses.map((characterClass) {
                  return DropdownMenuItem<CharacterClass>(
                    value: characterClass,
                    child: Text(characterClass.name),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Character Class',
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<CharacterRace>(
                value: characterRace,
                onChanged: setCharacterRace,
                items: availableRaces.map((characterRace) {
                  return DropdownMenuItem<CharacterRace>(
                    value: characterRace,
                    child: Text(characterRace.name),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Character Race',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: saveCharacter,
                child: Text('Save Character'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(CharacterCreatorApp());
}

class CharacterCreatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D&D Character Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CharacterCreatorScreen(),
    );
  }
}
