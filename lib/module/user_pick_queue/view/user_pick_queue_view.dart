// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:antrian_app/module/user_pick_queue/widget/first_box_pick_queue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/user_pick_queue/widget/second_box_pick_queue.dart';

class UserPickQueueView extends StatelessWidget {
  const UserPickQueueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPickQueueController>(
      init: UserPickQueueController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              "Main Screen",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  controller.getCurrentQueue();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Get.to(const CostumerPickQueueView())?.then((value) {
                    controller.getCurrentQueue();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Get.dialog(MDialogLogout(
                    onTap: () {
                      Get.offAll(const LoginView());
                    },
                  ));
                },
              )
            ],
          ),
          body: Responsive(
            desktop: isUserPickQueueDesktop(context, controller),
            tablet: isUserPickQueueDesktop(context, controller),
            mobile: isUserPickQueueMobile(context, controller),
          ),
        );
      },
    );
  }

  Widget isUserPickQueueMobile(
      BuildContext context, UserPickQueueController controller) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: FirstBoxPickQueue(
                layanan: controller.layanan,
                loket: controller.unit,
                nomorAntrian: controller.currentQueue),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: SecondBoxPickQueue(
                isMobile: true,
                numberWaiting: controller.waitingQueue,
                titleFunction1: "CALL",
                ontapFunction1: () {
                  controller.pickQueue();
                },
                titleFunction2: "RECALL",
                ontapFunction2: () {
                  controller.getCurrentQueue();
                },
                titleFunction3: "CONFIRM",
                ontapFunction3: () {
                  // controller.confirmQueue();
                },
                titleFunction4: "SKIP",
                ontapFunction4: () {
                  // controller.skipQueue();
                },
              )),
        ],
      ),
    );
  }

  Widget isUserPickQueueDesktop(
      BuildContext context, UserPickQueueController controller) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: FirstBoxPickQueue(
                layanan: controller.layanan,
                loket: controller.unit,
                nomorAntrian: controller.currentQueue),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: SecondBoxPickQueue(
                isMobile: false,
                numberWaiting: controller.waitingQueue,
                titleFunction1: "CALL",
                ontapFunction1: () {
                  controller.pickQueue();
                },
                titleFunction2: "RECALL",
                ontapFunction2: () {
                  // controller.recallQueue();
                  controller.getCurrentQueue();
                },
                titleFunction3: "CONFIRM",
                ontapFunction3: () {
                  // controller.confirmQueue();
                },
                titleFunction4: "SKIP",
                ontapFunction4: () {
                  // controller.skipQueue();
                },
              )),
        ],
      ),
    );
  }
}
