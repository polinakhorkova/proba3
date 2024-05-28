import 'package:get/get.dart';
import 'package:proba3/app/data/models/chat_message.dart';

import 'socket_service.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  String username = '';
  final messages = RxList<ChatMessage>.empty();

  Future<UserService> init() async {
    return this;
  }

  void setUsernameAndConnect(String user) {
    username = user;
    SocketService.to.connect();
  }

  void addNewMessageToList(ChatMessage message) {
    printInfo(info: "new message: $message");
    messages.add(message);
  }

  void clearMessage() => messages.clear();
}
