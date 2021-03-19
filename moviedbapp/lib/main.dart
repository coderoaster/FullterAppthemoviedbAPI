import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/PageHome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await DesktopWindow.setFullScreen(true);
  runApp(
    GetMaterialApp(
      title: 'FlutterAPP',
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
];
