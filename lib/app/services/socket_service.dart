import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../data/models/chat_message.dart';
import '../data/socket_event.dart';
import '../routes/app_pages.dart';
import 'user_service.dart';

class SocketService extends GetxService {
  static SocketService get to => Get.find();
  late Socket _socket;

  Future<SocketService> init() async {
    _socket = io(
        'https://masqed.ru',
        OptionBuilder()
            .setTransports(['websocket'])
            .setPath('/chat/socket.io')
            .disableAutoConnect()
            .disableReconnection()
            .build());

    _socket.onConnect((data) {
      printInfo(info: 'Socked connected');
      _sendLoginMessage();
      Get.offNamed(Routes.CHAT);
    });

    _socket.onDisconnect((data) {
      UserService.to.clearMessage();
      printInfo(info: 'Socket disconnected');
      Get.offNamed(Routes.HOME);
    });
    _socket
        .onConnectError((data) => printInfo(info: 'Socket connection error'));

    _socket.onAny((event, data) {
      var isKnown = SocketEvent.values.any((element) => element.name == event);
      if (!isKnown) return;
      data?['type'] = event;
      var message = ChatMessage.fromJson(data);
      UserService.to.addNewMessageToList(message);
    });

    return this;
  }

  String get clientId => _socket.id ?? "";

  void connect() {
    _socket.connect();
  }

  void disconnect() async {
    _sendLogoutMessage();
    await Future.delayed(const Duration(seconds: 2));
    _socket.disconnect();
  }

  void _sendLoginMessage() {
    _socket.emit(SocketEvent.login.name, UserService.to.username);
  }

  void _sendLogoutMessage() {
    _socket.emit(SocketEvent.logout.name);
  }

  void sendMessageToChat(String message) {
    _socket.emit(SocketEvent.newMessage.name, message);
  }
}
