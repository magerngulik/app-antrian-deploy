import 'package:antrian_app/constants.dart';
import 'package:antrian_app/module/navigation/controller/app_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TopBar extends GetView<AppController> {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isNotSm = size.width >= screenSm;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: .3,
            color: darkColor.withOpacity(.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isNotSm ? 24 : 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Spacer(),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: textColor,
                    size: 16,
                  ),
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 12,
                    ),
                    side: const BorderSide(color: textColor),
                    backgroundColor: Colors.transparent,
                    enableFeedback: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  label: const Text(
                    ' Notebook: UX Design Brainstorming',
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                const Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Syamsul Maarif'),
                        ),
                      ),
                      const PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.logout_outlined),
                          title: Text('LogOut'),
                        ),
                      ),
                      // Tambahkan item menu lainnya sesuai kebutuhan
                    ];
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
