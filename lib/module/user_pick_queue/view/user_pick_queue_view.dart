import 'package:flutter/material.dart';
import '../controller/user_pick_queue_controller.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class UserPickQueueView extends StatelessWidget {
  const UserPickQueueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPickQueueController>(
      init: UserPickQueueController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("UserPickQueue"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}
