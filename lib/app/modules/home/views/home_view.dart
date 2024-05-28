import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 206, 143, 215),
        appBar: AppBar(
          title: const Text(
            'Вход',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 147, 49, 177), // это мои цвета!!!!!!!! Я ВЗЯЛА ДРУГИЕЕЕЕЕЕЕ
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
         child:  Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              const Text(
                "Введите ваш никнейм",
                style: TextStyle(
                    fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ), Padding(padding: EdgeInsets.only(left:400, right:400),
              child:
              TextField(
                cursorColor: Colors.white,
                controller: controller.textCtrl,
                onSubmitted: (value) => controller.sighIn(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),),
            ],
          ),
        ),);
  }
}
