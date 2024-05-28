import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/socket_event.dart';
import '../controllers/chat_controller.dart';
import '../widget/bubble_message.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 143, 215),
      appBar: AppBar(
        title: const Text(
          'Чат',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 147, 49, 177), 
        actions: [
          IconButton(
              onPressed: () {
                controller.disconnect(); 
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
      ),
      body: Column( 
        children: [
          Expanded( 
              child: Obx(() => ListView.builder(
                
                    controller: controller.scrollCtrl, 
                    itemCount: controller.messages.length, 
                    itemBuilder: (context, index) {
                     
                      var message = controller.messages[index];
                      var itsMe = controller.itsMe(message.clientId);
                      switch (message.type) {
                        case SocketEvent.login:
                        
                          return Center(
                              child: Text(
                            "${message.username} вошел в чат!",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ));
                        case SocketEvent.logout:
                        
                          return Center(
                              child: Text(
                            "${message.username} вышел из чата!",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ));
                        case SocketEvent.newMessage: 
                          return BubbleMessage(message: message, itsMe: itsMe);
                        default: 
                          return const SizedBox();
                      }
                    },
                  ))),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField( 
              controller: controller.textCtrl, 
              onEditingComplete: controller.sendMessage(),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.sendMessage(),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
