import 'package:flutter/material.dart';
import '../controller/admin_home_controller.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(
      init: AdminHomeController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("AdminHome"),
          ),
          body: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.0,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: controller.data.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var items = controller.data[index];
              return InkWell(
                onTap: () {
                  if (items['no-services'] as bool == true) {
                    controller.noServices;
                  } else {
                    Get.to(items['onclick']);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    color: Colors.purpleAccent[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items['icon'] as IconData,
                        size: 100.0,
                        color: Colors.white,
                      ),
                      Text(
                        "${items['name']}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
