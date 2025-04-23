import '../../data/models/character/result.dart';
import '../../helper/const/my_colors.dart';
import 'package:flutter/material.dart';

class DetailsCharacterScreen extends StatelessWidget {
  const DetailsCharacterScreen({super.key, required this.character});
  final Result character;
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      stretch: true,
      pinned: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: character.id!,
          child: Image.network(
            character.image!,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          character.name!,
          style: TextStyle(color: MyColors.yellow, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.yellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Status : ', character.status!),
                      buildDivider(290),
                      characterInfo('Species : ', character.species!),
                      buildDivider(280),
                      characterInfo('Gender : ', character.gender!),
                      buildDivider(290),
                      characterInfo('Location : ', character.location!.name!),
                      buildDivider(275),
                      characterInfo(
                          'Created : ', character.created!.toString()),
                      buildDivider(270),
                    ],
                  ),
                ),
                SizedBox(
                  height: 600,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
