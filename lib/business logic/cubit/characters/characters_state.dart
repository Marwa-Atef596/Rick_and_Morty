part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersSuccess extends CharactersState {
  final List<Result> characters;

  CharactersSuccess(this.characters);
}

final class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
