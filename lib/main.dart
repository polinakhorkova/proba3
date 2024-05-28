import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proba3/app/services/socket_service.dart';
import 'package:proba3/app/services/user_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await initServices(); 
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
Future<void> initServices() async { 
  await Get.putAsync(() => SocketService().init());
  await Get.putAsync(() => UserService().init());
}
