// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/layar/widget/m_container_layer.dart';

import '../controller/layar_controller.dart';

class LayarView extends StatelessWidget {
  const LayarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayarController>(
      init: LayarController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("Layar"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      child: MContainerLayar1(controller: controller)),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(controller.dataList.length, (index) {
                          var margin = index == 0 ? 0.0 : 20.0;
                          var item = controller.dataList[index];
                          var userCode = "-";
                          if (item['queue'] != null) {
                            userCode = item['queue']['kode'];
                          }
                          return MContainerLayer(
                              margin: margin,
                              loket: item['nama_role'],
                              kode: userCode);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MContainerLayar1 extends StatelessWidget {
  final LayarController controller;

  const MContainerLayar1({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: isDesktopLayarContainer1(),
      tablet: isTabletLayarContainer1(),
      mobile: isMobileLayarContainer1(),
    );
  }

  Widget isMobileLayarContainer1() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 20.0,
                color: Colors.grey[350]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  50.0,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nomor Panggilan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.loket,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.kodePelayanan,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 20.0,
                color: Colors.grey[350]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  50.0,
                ),
              ),
            ),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget isTabletLayarContainer1() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 20.0,
                color: Colors.grey[350]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  50.0,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nomor Panggilan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.loket,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.kodePelayanan,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 20.0,
                color: Colors.grey[350]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  50.0,
                ),
              ),
            ),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget isDesktopLayarContainer1() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 20.0,
                color: Colors.grey[350]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  50.0,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Nomor Panggilan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.loket,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.kodePelayanan,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 20.0,
                color: Colors.grey[350]!,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  50.0,
                ),
              ),
            ),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
