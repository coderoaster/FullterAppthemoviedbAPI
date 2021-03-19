import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/detail.dart';
import 'package:moviedbapp/models/results.dart';
import 'package:moviedbapp/network/api.dart';

class PagedetailController extends GetxController {
  RxString playlist;

  init(String id) async {
    final apiItem = await Api().detail(int.parse(id));
    playlist = apiItem.obs;
  }
}

class Pagedetail extends StatelessWidget {
  final PagedetailController c = Get.put(PagedetailController());
  final id = Get.arguments;
  @override
  Widget build(context) {
    c.init(id);
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
          ],
        )),
      ),
    ));
  }
}
