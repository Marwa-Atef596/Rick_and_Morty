import '../../data/models/character/result.dart';
import '../../helper/const/my_colors.dart';
import '../../helper/const/strings.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});
  final Result character;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap:()=> Navigator.pushNamed(context,characterDetailsScreen,arguments: character),
          child: GridTile(
            footer: Hero(
              tag: character.id!,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  character.name ?? 'No name',
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 16,
                    color: MyColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: Container(
              color: MyColors.grey,
              child: (character.image != null && character.image!.isNotEmpty)
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/Animation - 1745068234564.gif',
                      image: character.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/Image_not_available.png'),
            ),
          ),
        ));
  }
}
