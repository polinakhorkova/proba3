import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proba3/app/services/user_service.dart';

class HomeController extends GetxController {
  final textCtrl = TextEditingController();

  void sighIn() {
    String username = textCtrl.text;
    print(username);
    UserService.to.setUsernameAndConnect(username);
  }
}
