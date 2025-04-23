// ignore_for_file: unused_element, non_constant_identifier_names
import 'package:breaking_bad/business%20logic/cubit/characters/characters_cubit.dart';
import 'package:breaking_bad/data/models/character/result.dart';
import 'package:breaking_bad/helper/const/my_colors.dart';
import 'package:breaking_bad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharctersScreen extends StatefulWidget {
  const CharctersScreen({super.key});

  @override
  State<CharctersScreen> createState() => _CharctersScreenState();
}

class _CharctersScreenState extends State<CharctersScreen> {
  List<Result> allCharacter = [];
  List<Result> searchForCharacter = [];
  bool isSearching = false;
  // ignore: unused_field
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.grey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.grey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.grey, fontSize: 18),
      onChanged: (SearchedCharacter) {
        addToSearchedList(SearchedCharacter);
      },
    );
  }

  void addToSearchedList(String SearchedCharacter) {
    searchForCharacter = allCharacter
        .where((character) =>
            character.name!.toLowerCase().startsWith(SearchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppAction() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.grey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.grey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget characterBody() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersSuccess) {
        allCharacter = state.characters;
        return buildGridList();
      } else {
        return showLoadindIndicator();
      }
    });
  }

  Widget buildGridList() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(
          children: [
            characterList(),
          ],
        ),
      ),
    );
  }

  Widget characterList() {
    final List<Result> charactersToShow =
        _searchTextController.text.isEmpty ? allCharacter : searchForCharacter;

    if (charactersToShow.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
            ),
            Image.asset(
              'assets/images/Animation - 1745248255912.gif',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            const Text(
              'No characters found.',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.yellow),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: _searchTextController.text.isEmpty
          ? allCharacter.length
          : searchForCharacter.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacter[index]
              : searchForCharacter[index],
        );
      },
    );
  }

  Widget showLoadindIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.yellow,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.grey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.grey,
              ),
            ),
            Image.asset('assets/images/undraw_ai-code-generation_imyw.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      appBar: AppBar(
          backgroundColor: MyColors.yellow,
          actions: _buildAppAction(),
          title: isSearching ? _buildSearchField() : _buildAppBarTitle()),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return characterBody();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadindIndicator(),
      ),
    );
  }
}
