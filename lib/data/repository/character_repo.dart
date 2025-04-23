import '../api_services/character_api_services.dart';

import '../models/character/result.dart';

class CharacterRepo {
  final CharacterApiServices characterApiServices;

  CharacterRepo({required this.characterApiServices});

  Future<List<Result>> getAllCharacters() async {
    final data = await characterApiServices.getAllCharacter();
    final List<dynamic> resultsJson = data['results'] ?? [];

    return resultsJson
        .map((json) => Result.fromJson(json as Map<String, dynamic>))
        .toList();

    // final Character character = Character.fromJson(data);//mapping
    // return character.results ?? [];
  }

  // Future<List<Character>> getAllCharacter() async {
  //   final data = await characterApiServices.getAllCharacter();
  //   final List<dynamic> charactersJson = data['results'];
  //   print('data is::${charactersJson.toString()}');
  //   return charactersJson
  //       .map((json) => Character.fromJson(json as Map<String, dynamic>))
  //       .toList();
  // }
}
