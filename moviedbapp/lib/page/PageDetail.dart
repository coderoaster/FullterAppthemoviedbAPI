import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/castmembers.dart';
import 'package:moviedbapp/models/detail.dart';
import 'package:moviedbapp/network/api.dart';

class PagedetailController extends GetxController {
  RxList<Castmembers> castlist;

  init(String id) async {
    final apiItem = await Api().cast(int.parse(id));
    castlist = apiItem.obs;
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
            Obx(() => Text('${c.castlist[0].name}')),
          ],
        )),
      ),
    ));
  }
}
