import 'info.dart';
import 'result.dart';

class Character {
  Info? info;
  List<Result>? results;

  Character({this.info, this.results});

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        info: json['info'] == null
            ? null
            : Info.fromJson(json['info'] as Map<String, dynamic>),
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'info': info?.toJson(),
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
