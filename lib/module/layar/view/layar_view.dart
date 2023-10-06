import 'package:antrian_app/module/layar/widget/m_container_layer.dart';
import 'package:flutter/material.dart';
import '../controller/layar_controller.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

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
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
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
                                  style: const TextStyle(
                                    fontSize: 100.0,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
