import 'package:antrian_app/shared/services/m_logger.dart';
import 'package:flutter/material.dart';
import '../controller/user_pick_role_controller.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class UserPickRoleView extends StatelessWidget {
  const UserPickRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPickRoleController>(
      init: UserPickRoleController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              "Role User",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: const [],
          ),
          bottomNavigationBar: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () {
                  controller.postRole();
                },
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const FittedBox(
                    child: Text(
                      "Harap pilih role yang tersedia terlebih dahulu",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: controller.isDesktop(context) ? 100.0 : 25,
                  ),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.center,
                    children:
                        List.generate(controller.dataRole.length, (index) {
                      var warna = Colors.orangeAccent;
                      var data = controller.dataRole[index];

                      int id = data['id'];
                      return InkWell(
                        onTap: () {
                          controller.pickRole(
                              index: index, selectedRoleData: id);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: warna,
                              border: (controller.selectedIndex == index)
                                  ? Border.all(
                                      width: 5.0,
                                      color: Colors.purple,
                                    )
                                  : const Border()),
                          child: Center(
                            child: Text(
                              "${data['name_role']}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
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
