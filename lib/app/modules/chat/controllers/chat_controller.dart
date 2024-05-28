import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/chat_message.dart';
import '../../../services/socket_service.dart';
import '../../../services/user_service.dart';

class ChatController extends GetxController {
RxList<ChatMessage> get messages => UserService.to.messages;
  final textCtrl = TextEditingController();
  final scrollCtrl = ScrollController();

  @override
  void onInit() {
  
  messages.listen((_) async { 
    if (scrollCtrl.hasClients) {
     var max = scrollCtrl.position.maxScrollExtent; 
     if (scrollCtrl.offset + 100 >= max) {
         await Future.delayed(
          const Duration(milliseconds: 100),
          () {
          if (scrollCtrl.hasClients) {  
              scrollCtrl.jumpTo(scrollCtrl.position.maxScrollExtent);
            }
          },
        );
      }
    }
  });
 super.onInit();
}


  void disconnect() { 
    
    SocketService.to.disconnect();
  }

  bool itsMe(String clientId) => clientId == SocketService.to.clientId; 

  sendMessage() { 
    var message = textCtrl.text; 
    if (message.isNotEmpty) SocketService.to.sendMessageToChat(message);
    textCtrl.clear(); 
  }

  @override
  void onClose() {
    scrollCtrl.dispose();
    super.onClose();
  }
}

