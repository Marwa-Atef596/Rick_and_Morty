// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/character/result.dart';
import 'package:breaking_bad/data/repository/character_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepo characterRepo;
  List<Result> characters = [];
  CharactersCubit(this.characterRepo) : super(CharactersInitial());
  Future<void> getAllCharacter() async {
    try {
      final characters = await characterRepo.getAllCharacters();
      this.characters = characters;
      emit(CharactersSuccess(characters));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
  // List<Result> getAllCharacter() {
  //   characterRepo.getAllCharacters().then((characters) {
  //     emit(CharactersSuccess(characters.cast<Result>()));
  //     this.characters = characters.cast<Result>();
  //   });
  //   return characters;
  // }
}
