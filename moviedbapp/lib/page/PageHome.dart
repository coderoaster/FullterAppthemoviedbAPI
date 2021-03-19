import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/results.dart';
import 'package:moviedbapp/network/api.dart';

class HomeController extends GetxController {
  RxList<Results> playlist;

  RxInt playlistCount = 0.obs;

  init() async {
    final apiItem = await Api().playing();
    playlist = apiItem.obs;
    playlistCount = apiItem.length.obs;
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
          children: <Widget>[
            Text(
              '현재 상영중',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Obx(() =>
                      Image.network("$IMAGE_URL${c.playlist[0].posterPath}")),
                  Obx(
                    () => Text("${c.playlist[0].title}"),
                  ),
                  Obx(
                    () => Text("평점 : ${c.playlist[0].voteAverage}"),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    ));
  }
}
//  width: Get.width - 250,
//     height: 80,
//     child: Obx(
//       () {
//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: c.playlistCount.toInt(),
//           itemBuilder: (context, index) {

//           },
//         );
//       },
//     ),
