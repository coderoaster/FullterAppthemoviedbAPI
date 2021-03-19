import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/models/castmembers.dart';
import 'package:moviedbapp/models/detail.dart';
import 'package:moviedbapp/models/results.dart';
import '../common/config.dart';

class Api extends GetConnect {
  Future<List<Results>> playing() async {
    try {
      Response response =
          await get("$API_URL/movie/now_playing$API_Key$API_LANGUAGE");
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

  Future<List<Results>> upcoming() async {
    try {
      Response response =
          await get("$API_URL/movie/upcoming$API_Key$API_LANGUAGE");
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

  Future<List<Detail>> detail(int movieId) async {
    try {
      Response response =
          await get("$API_URL/movie/$movieId$API_Key$API_LANGUAGE");
      final body = response.body;

      List<Detail> output = [];

      final resultsModel = Detail.fromJson(body);

      output.add(resultsModel);
      return output;
    } catch (e) {
      debugPrint(e);
      return [];
    }
  }

  Future<List<Castmembers>> cast(int movieId) async {
    try {
      Response response =
          await get("$API_URL/movie/$movieId/credits$API_Key$API_LANGUAGE");
      final body = response.body;

      List<dynamic> list = body['cast'] != null ? body['cast'] : [];

      List<Castmembers> output = [];

      for (final item in list) {
        final resultsModel = Castmembers.fromJson(item);

        output.add(resultsModel);
      }

      return output;
    } catch (e) {
      debugPrint(e);
      return [];
    }
  }
}
