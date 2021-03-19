import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/castmembers.dart';
import 'package:moviedbapp/models/detail.dart';
import 'package:moviedbapp/network/api.dart';

class PagedetailController extends GetxController {
  RxList<Castmembers> castlist;
  RxList<Detail> detail;

  init(String id) async {
    final apicast = await Api().cast(int.parse(id));
    castlist = apicast.obs;
    final apidetail = await Api().detail(int.parse(id));
    detail = apidetail.obs;
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Obx(() => Image.network(
                      "$IMAGE_URL${c.detail[0].posterPath}",
                    )),
                Obx(() => Text('${c.detail[0].title}')),
                Text('개요'),
                Obx(() => Text('${c.detail[0].overview}')),
                Text('주요출연진'),
                Container(
                  child: Column(
                    children: <Widget>[
                      Obx(
                        () => Image.network(
                            '$IMAGE_URL${c.castlist[0].profilePath}'),
                      ),
                      Obx(() => Text('${c.castlist[0].name}'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
