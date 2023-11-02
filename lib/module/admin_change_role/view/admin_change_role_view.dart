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
            ),
            body: ListView.builder(
              itemCount: controller.listRoles.length,
              itemBuilder: (context, index) {
                var items = controller.listRoles[index];
                if (controller.listRoles.isEmpty) {
                  return const Center(
                    child: Text("Belum ada data user pada hari ini"),
                  );
                } else {
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
                }
              },
            ));
      },
    );
  }
}
