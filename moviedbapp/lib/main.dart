import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/config.dart';
import 'page/PageHome.dart';
import 'page/PageDetail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await DesktopWindow.setFullScreen(true);
  runApp(
    GetMaterialApp(
      title: AppTitle,
      initialRoute: '/home',
      getPages: pages,
    ),
  );
}

final pages = [
  // Simple GetPage
  GetPage(
    name: '/home',
    transition: Transition.fade,
    page: () => PageHome(),
  ),
  GetPage(
    name: '/detail',
    transition: Transition.fade,
    page: () => Pagedetail(),
  ),
];
