// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:breaking_bad/helper/const/strings.dart';
import 'package:dio/dio.dart';

class CharacterApiServices {
  Dio dio = Dio();

  CharacterApiServices() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ));
  }
  Future<Map<String, dynamic>> getAllCharacter() async {
    try {
      Response response = await dio.get('character');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
