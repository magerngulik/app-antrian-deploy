import 'package:flutter/material.dart';
import '../controller/admin_change_role_controller.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class AdminChangeRoleView extends StatelessWidget {
  const AdminChangeRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminChangeRoleController>(
      init: AdminChangeRoleController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: const Text("Admin Change Role"),
              actions: [
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
            body: controller.listRoles.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.listRoles.length,
                    itemBuilder: (context, index) {
                      var items = controller.listRoles[index];
                      debugPrint("Jumlah Data: ${controller.listRoles.length}");

                      debugPrint(
                          "KOndisi terpenuhi Jumlah Data: ${controller.listRoles.length}");

                      return Card(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.purple,
                        child: ListTile(
                          title: Text(
                            "${items['role']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            "${items['user']}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              controller.deleteRoleToday(items['id']);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "Belum ada data untuk hari ini",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    ),
                  ));
      },
    );
  }
}
