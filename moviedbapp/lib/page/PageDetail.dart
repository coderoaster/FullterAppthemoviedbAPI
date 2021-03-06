import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/castmembers.dart';
import 'package:moviedbapp/models/detail.dart';
import 'package:moviedbapp/models/reviews.dart';
import 'package:moviedbapp/network/api.dart';

class PagedetailController extends GetxController {
  RxList<Castmembers> castlist;
  RxList<Detail> detail;
  RxList<Reviews> reviews;

  RxInt castlistcount = 0.obs;
  RxInt reviewscount = 0.obs;

  init(String id) async {
    final apicast = await Api().cast(int.parse(id));
    castlist = apicast.obs;
    castlistcount = apicast.length.obs;
    final apidetail = await Api().detail(int.parse(id));
    detail = apidetail.obs;
    final apireviews = await Api().reviews(int.parse(id));
    reviews = apireviews.obs;
    reviewscount = apireviews.length.obs;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Obx(
                        () => Image.network(
                          "$IMAGE_URL${c.detail[0].posterPath}",
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Obx(() => Text('${c.detail[0].title}')),
                            Obx(() => Text('adult : ${c.detail[0].adult}')),
                            Obx(() => Text(
                                '${c.detail[0].genres[0].name}${c.detail[0].genres[1].name}')),
                            Obx(() => Text('????????? : ${c.detail[0].releaseDate}')),
                            Obx(() => Text('?????? : ${c.detail[0].voteAverage}')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    '??????',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    width: context.width - 30,
                    child: Obx(() => Text('${c.detail[0].overview}'))),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    '???????????????',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '??????',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 300,
                  height: 200,
                  child: Obx(() {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: c.reviewscount.toInt(),
                      itemBuilder: (context, index) {
                        return Review(
                          content: c.reviews[index].content,
                          user: c.reviews[index].author,
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

class Review extends StatelessWidget {
  final String content;
  final String user;
  const Review({
    Key key,
    this.content,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), //???????????? ?????????
          border: Border.all(color: Colors.black12, width: 3)),
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 20.0,
      ),
      width: 300,
      height: 100,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('$content'),
            Text('???????????? : $user'),
          ],
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
