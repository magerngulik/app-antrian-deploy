import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/queue_list.dart';
import '../view/antrian_view.dart';

class AntrianController extends GetxController {
  AntrianView? view;

  List<Map<String, dynamic>> listCounter = [
    {
      "no_counter": 1,
      "now_queue": 'A003',
    },
    {
      "no_counter": 2,
      "now_queue": 'B002',
    },
    {
      "no_counter": 3,
      "now_queue": 'C006',
    },
    {
      "no_counter": 4,
      "now_queue": 'D003',
    },
    {
      "no_counter": 5,
      "now_queue": 'E008',
    },
    {
      "no_counter": 6,
      "now_queue": 'F002',
    },
  ];
  final List<QueueItem> queueList = [
    QueueItem('002', 1),
    QueueItem('003', 2),
    QueueItem('004', 3),
    // Tambahkan item antrian lainnya di sini
  ];

  final List<Color> randomColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  Color getRandomColor() {
    final random = Random();
    return randomColors[random.nextInt(randomColors.length)];
  }
}
