import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/models/results.dart';
import 'package:moviedbapp/network/api.dart';

class HomeController extends GetxController {
  RxList<Results> playlist;

  RxInt playlistCount = 0.obs;

  init() async {
    final apiItem = await Api().playing();
    playlist = apiItem.obs;
  }
}

class PageHome extends StatelessWidget {
  final HomeController c = Get.put(HomeController());
  @override
  Widget build(context) {
    c.init();
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      child: Center(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[Text('현재 상영중')],
        )),
      ),
    ));
  }
}
