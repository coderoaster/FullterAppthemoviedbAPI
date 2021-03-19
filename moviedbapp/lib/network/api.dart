import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/models/results.dart';
import '../common/config.dart';

class Api extends GetConnect {
  Future<List<Results>> playing() async {
    try {
      Response response =
          await get("$API_URL/movie/popular$API_Key$API_LANGUAGE");
      final body = response.body;
      // print(body);
      List<dynamic> list = body['results'] != null ? body['results'] : [];

      List<Results> output = [];

      for (final item in list) {
        final resultsModel = Results.fromJson(item);
        output.add(resultsModel);
      }

      return output;
    } catch (e) {
      debugPrint(e);
      return [];
    }
  }

  // Future<List<Results>> images(int movie_id) async {
  //   try {
  //     Response response = await get("$API_URL/movie/$movie_id/images$API_Key");
  //     final body = response.body;
  //     // print(body);
  //     List<dynamic> list = body['results'] != null ? body['results'] : [];

  //     List<Results> output = [];

  //     for (final item in list) {
  //       final resultsModel = Results.fromJson(item);
  //       output.add(resultsModel);
  //     }

  //     return output;
  //   } catch (e) {
  //     debugPrint(e);
  //     return [];
  //   }
  // }
}
