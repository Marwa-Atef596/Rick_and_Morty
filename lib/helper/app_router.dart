import '../business%20logic/cubit/characters/characters_cubit.dart';
import '../data/api_services/character_api_services.dart';
import '../data/models/character/result.dart';
import '../data/repository/character_repo.dart';
import 'const/strings.dart';
import '../presentation/screens/charcters_screen.dart';
import '../presentation/screens/details_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharactersCubit charactersCubit;
  AppRouter() {
    characterRepo = CharacterRepo(characterApiServices: CharacterApiServices());
    charactersCubit = CharactersCubit(characterRepo);
  }

  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharctersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Result;
        return MaterialPageRoute(
          builder: (_) => DetailsCharacterScreen(
            character: character,
          ),
        );
    }
    return null;
  }
}
