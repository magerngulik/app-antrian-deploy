import 'package:flutter/material.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          // appBar: AppBar(
          //   title: const Text("Dashboard"),
          // ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.84,
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Teller",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Text(
                                          " ${controller.totalUser?['teller_count'] ?? 0}",
                                          style: const TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          8.0,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.computer,
                                      size: 48.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Customer Service",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Text(
                                          " ${controller.totalUser?['customer_service_count'] ?? 0}",
                                          style: const TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          8.0,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.person_2,
                                      size: 48.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Operator",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Text(
                                          " ${controller.totalUser?['total_operator'] ?? 0}",
                                          style: const TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          8.0,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 48.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.75,
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
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    8.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: const Text(
                                      "Jumlah Antrian Pengunjung Hari Ini",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),
                                  const Divider(
                                    height: 2,
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                  ListView.builder(
                                    itemCount: controller.listCounter.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    clipBehavior: Clip.none,
                                    itemBuilder: (context, index) {
                                      var item = controller.listCounter[index];
                                      return Card(
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.computer,
                                            size: 24.0,
                                          ),
                                          title: Text(
                                              "Counter ${item['no_counter']}"),
                                          subtitle:
                                              Text(item['operator_counter']),
                                          trailing: SizedBox(
                                            width: 120.0,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  controller.getColorForQueue(
                                                      item['total_antrian']),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item['total_antrian']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    8.0,
                                  ),
                                ),
                              ),
                              child: const Profile(),
                            ),
                          ),
                        ),
                      ],
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
