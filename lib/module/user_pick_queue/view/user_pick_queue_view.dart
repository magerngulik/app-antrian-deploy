// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:antrian_app/module/user_pick_queue/widget/firstBoxPickQueue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/user_pick_queue/widget/secondBoxPickQueue.dart';

import '../controller/user_pick_queue_controller.dart';

class UserPickQueueView extends StatelessWidget {
  const UserPickQueueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPickQueueController>(
      init: UserPickQueueController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  child: const FirstBoxPickQueue(
                      layanan: "Costumer Services",
                      loket: "Costumer services 1",
                      nomorAntrian: "A002"),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: SecondBoxPickQueue(
                      numberWaiting: 99,
                      titleFunction1: "Call",
                      ontapFunction1: () {
                        debugPrint("data 1");
                      },
                      titleFunction2: "RECALL",
                      ontapFunction2: () {
                        debugPrint("data 2");
                      },
                      titleFunction3: "CONFIRM",
                      ontapFunction3: () {
                        debugPrint("data 3");
                      },
                      titleFunction4: "SKIP",
                      ontapFunction4: () {
                        debugPrint("data 4");
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
