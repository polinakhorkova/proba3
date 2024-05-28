import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/models/chat_message.dart';


class BubbleMessage extends StatelessWidget {
  final ChatMessage message;
  final bool itsMe;
  const BubbleMessage({super.key, required this.message, required this.itsMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: itsMe ? Alignment.topRight : Alignment.topLeft,
      
      child: Container( padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5, bottom: 10, left: itsMe ? 60: 15, right: itsMe ? 10 : 60),
       color:  itsMe
       ? Color.fromARGB(255, 184, 68, 196)
       : Color.fromARGB(255, 147, 49, 177), 
       child: Column( children: [
        if (!itsMe)
        Text( message.username),
        if (!itsMe) const SizedBox(height: 5),
        Text(message.message )
       ],),
      ),
    );
  }
}
