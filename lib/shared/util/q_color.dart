import 'package:flutter/material.dart';

class ColorManager {
  final List<Color> _availableColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
  ];

  final List<Color> _previousColors = [];

  Color getNextColor() {
    // Jika daftar warna kosong, tambahkan semua warna yang tersedia sebelumnya ke daftar
    if (_availableColors.isEmpty) {
      _availableColors.addAll(_previousColors);
    }

    final color = _availableColors.removeAt(0);

    // Simpan warna yang baru digunakan ke dalam daftar warna yang tersedia sebelumnya
    _previousColors.add(color);

    return color;
  }
}
