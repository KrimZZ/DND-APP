class Character {
  final String name;
  final CharacterClass characterClass;
  final CharacterRace characterRace;

  Character({
    required this.name,
    required this.characterClass,
    required this.characterRace,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      characterClass: CharacterClass.fromJson(json['characterClass']),
      characterRace: CharacterRace.fromJson(json['characterRace']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'characterClass': characterClass.toJson(),
      'characterRace': characterRace.toJson(),
    };
  }
}

class CharacterClass {
  final String name;

  CharacterClass({required this.name});

  factory CharacterClass.fromJson(Map<String, dynamic> json) {
    return CharacterClass(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class CharacterRace {
  final String name;

  CharacterRace({required this.name});

  factory CharacterRace.fromJson(Map<String, dynamic> json) {
    return CharacterRace(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
