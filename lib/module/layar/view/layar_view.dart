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
          appBar: AppBar(
            title: const Text("Layar"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}
