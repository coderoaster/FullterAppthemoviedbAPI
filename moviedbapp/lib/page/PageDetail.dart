import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/castmembers.dart';
import 'package:moviedbapp/models/detail.dart';
import 'package:moviedbapp/network/api.dart';

class PagedetailController extends GetxController {
  RxList<Castmembers> castlist;
  RxList<Detail> detail;

  RxInt castlistcount = 0.obs;

  init(String id) async {
    final apicast = await Api().cast(int.parse(id));
    castlist = apicast.obs;
    castlistcount = apicast.length.obs;
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
        width: context.width,
        height: context.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Obx(
                      () => Image.network(
                        "$IMAGE_URL${c.detail[0].posterPath}",
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Obx(() => Text('${c.detail[0].title}')),
                        Obx(() => Text('adult : ${c.detail[0].adult}')),
                        Obx(() => Text(
                            '${c.detail[0].genres[0].name}${c.detail[0].genres[1].name}')),
                        Obx(() => Text('발매일 : ${c.detail[0].releaseDate}')),
                        Obx(() => Text('평점 : ${c.detail[0].voteAverage}')),
                      ],
                    )
                  ],
                ),
                Text('개요'),
                Obx(() => Text('${c.detail[0].overview}')),
                Text('주요출연진'),
                Container(
                  width: Get.width,
                  height: 400,
                  child: Obx(() {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: c.castlistcount.toInt(),
                      itemBuilder: (context, index) {
                        return CastList(
                          profilePath: c.castlist[index].profilePath,
                          name: c.castlist[index].name,
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CastList extends StatelessWidget {
  final String profilePath;
  final String name;
  const CastList({
    Key key,
    this.profilePath,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          if (profilePath != null) Image.network('$IMAGE_URL$profilePath'),
          if (profilePath != null) Text('$name')
        ],
      ),
    );
  }
}
