import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedbapp/common/config.dart';
import 'package:moviedbapp/models/movieList.dart';
import 'package:moviedbapp/network/api.dart';

class HomeController extends GetxController {
  RxList<MovieList> playlist;
  RxList<MovieList> upcominglist;
  RxList<MovieList> popularlist;
  RxList<MovieList> topratedlist;

  RxInt playlistCount = 0.obs;
  RxInt upcomingCount = 0.obs;
  RxInt popularCount = 0.obs;
  RxInt topratedCount = 0.obs;

  init() async {
    final playListdata = await Api().playing();
    playlist = playListdata.obs;
    playlistCount = playListdata.length.obs;

    final upcominglistdata = await Api().upcoming();
    upcominglist = upcominglistdata.obs;
    upcomingCount = upcominglistdata.length.obs;

    final popularlistdata = await Api().popular();
    popularlist = popularlistdata.obs;
    popularCount = popularlistdata.length.obs;

    final topratedlisttdata = await Api().toprated();
    topratedlist = topratedlisttdata.obs;
    topratedCount = topratedlisttdata.length.obs;
  }
}

class PageHome extends StatelessWidget {
  final HomeController c = Get.put(HomeController());
  @override
  Widget build(context) {
    c.init();
    return Scaffold(
        body: Container(
      width: context.width,
      height: context.height,
      child: Center(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 43,
            ),
            Text(
              '현재 상영중',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: 500,
              height: 380,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.upcomingCount.toInt(),
                  itemBuilder: (context, index) {
                    return PlayList(
                      id: c.playlist[index].id,
                      post: c.playlist[index].posterPath,
                      title: c.playlist[index].title,
                      voteAverage: c.playlist[index].voteAverage,
                    );
                  },
                );
              }),
            ),
            Text(
              '개봉예정',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: 500,
              height: 380,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.playlistCount.toInt(),
                  itemBuilder: (context, index) {
                    return PlayList(
                      id: c.upcominglist[index].id,
                      post: c.upcominglist[index].posterPath,
                      title: c.upcominglist[index].title,
                      voteAverage: c.upcominglist[index].voteAverage,
                    );
                  },
                );
              }),
            ),
            Text(
              '인기',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: 500,
              height: 380,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.popularCount.toInt(),
                  itemBuilder: (context, index) {
                    return PlayList(
                      id: c.popularlist[index].id,
                      post: c.popularlist[index].posterPath,
                      title: c.popularlist[index].title,
                      voteAverage: c.popularlist[index].voteAverage,
                    );
                  },
                );
              }),
            ),
            Text(
              '높은평점',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: 500,
              height: 380,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.topratedCount.toInt(),
                  itemBuilder: (context, index) {
                    return PlayList(
                      id: c.topratedlist[index].id,
                      post: c.topratedlist[index].posterPath,
                      title: c.topratedlist[index].title,
                      voteAverage: c.topratedlist[index].voteAverage,
                    );
                  },
                );
              }),
            ),
          ],
        )),
      ),
    ));
  }
}

class PlayList extends StatelessWidget {
  final int id;
  final String post;
  final String title;
  final num voteAverage;
  const PlayList({
    Key key,
    this.id,
    this.post,
    this.title,
    this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/detail", arguments: "$id");
      },
      child: Container(
        margin: const EdgeInsets.only(left: 17),
        child: Column(
          children: <Widget>[
            Image.network("$IMAGE_URL$post"),
            Text(
              "$title",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "평점 : $voteAverage",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
