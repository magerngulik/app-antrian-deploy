import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:marquee/marquee.dart';

import '../controller/costumer_pick_queue_controller.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class CostumerPickQueueView extends StatelessWidget {
  const CostumerPickQueueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostumerPickQueueController>(
      init: CostumerPickQueueController(),
      builder: (controller) {
        controller.view = this;

        bool isMobile = MediaQuery.of(context).size.width < 850;

        return Scaffold(
          backgroundColor: const Color(0xff5b7c99),
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "Bank ABC".toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.formattedDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.getCurrentTime(controller.currentTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),
          bottomNavigationBar: isMobile
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : Container(
                  height: MediaQuery.of(context).size.height / 12,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                  ),
                  child:

                      // Positioned(
                      //   right: 0,
                      //   child: AnimatedTextKit(
                      //     animatedTexts: [
                      //       TyperAnimatedText(
                      //         "Pelayanan ${controller.namaInstansi} akan dibuka mulai dari ${controller.layananBuka} dan ditutup pada ${controller.layananTutup}. Terimakasih atas kunjungan Anda, kami akan melayani Anda dengan sepenuh hati.",

                      //         textAlign: TextAlign.right,
                      //         speed: const Duration(milliseconds: 100),
                      //       ),
                      //     ],
                      //     totalRepeatCount: 2,
                      //     pause: const Duration(
                      //         milliseconds: 1000), // Jeda sebelum mengulang
                      //   ),
                      // ),
                      Marquee(
                    text:
                        "Pelayanan ${controller.namaInstansi} akan dibuka mulai dari ${controller.layananBuka} dan ditutup pada ${controller.layananTutup}. Terimakasih atas kunjungan Anda, kami akan melayani Anda dengan sepenuh hati.",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: const Duration(seconds: 2),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 2),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  )),
          body: Responsive(
            desktop: isDesktopQueueCostumer(context, controller),
            tablet: isTabletQueueCostumer(context, controller),
            mobile: isMobileQueueCostumer(context, controller),
          ),
        );
      },
    );
  }

  Widget isMobileQueueCostumer(
      BuildContext context, CostumerPickQueueController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  media!['link'],
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    const FittedBox(
                      child: Text(
                        "Ambil Antrian",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: List.generate(controller.data.length, (index) {
                        var item = controller.data[index];
                        Color color = controller.colorManager.getNextColor();
                        var jumlah = (index > 4) ? 20 : 2;

                        return InkWell(
                          onTap: () {
                            controller.getTicketQueue(item['id']);
                          },
                          child: Container(
                            height: Get.width / jumlah,
                            width: Get.width / jumlah,
                            margin: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${item['name']}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget isTabletQueueCostumer(
      BuildContext context, CostumerPickQueueController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  media!['link'],
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    const FittedBox(
                      child: Text(
                        "Ambil Antrian",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(controller.data.length, (index) {
                        var item = controller.data[index];
                        Color color = controller.colorManager.getNextColor();
                        var jumlah = (index > 4) ? 20 : 3;

                        return InkWell(
                          onTap: () {
                            controller.getTicketQueue(item['id']);
                          },
                          child: Container(
                            height: Get.height / jumlah,
                            width: Get.width / jumlah,
                            margin: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${item['name']}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget isDesktopQueueCostumer(
      BuildContext context, CostumerPickQueueController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  media!['link'],
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    const FittedBox(
                      child: Text(
                        "Ambil Antrian",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(controller.data.length, (index) {
                        var item = controller.data[index];
                        Color color = controller.colorManager.getNextColor();
                        var jumlah = (index > 4) ? 20 : 5;

                        return InkWell(
                          onTap: () {
                            // print("id: ${item['id']}");
                            // controller.getTicketQueue(item['id']);
                            controller.getTicketQueueSupabase(item['id']);
                          },
                          child: Container(
                            height: Get.height / jumlah,
                            width: Get.width / jumlah,
                            margin: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "${item['name']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blueGrey,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    //   onPressed: () => controller.testDialog(),
                    //   child: const Text("Save"),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
