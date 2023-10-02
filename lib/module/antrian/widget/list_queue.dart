import 'package:flutter/material.dart';

import '../../../models/queue_list.dart';

class QueueListScreen extends StatelessWidget {
  final List<QueueItem> queueList;

  const QueueListScreen({super.key, required this.queueList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('No')),
        DataColumn(label: Text('Nomor Anterian')),
        DataColumn(label: Center(child: Text('Aksi'))),
      ],
      rows: queueList.map((item) {
        return DataRow(cells: [
          DataCell(Text(item.queueNumber.toString())),
          DataCell(Text(item.name)),
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika pemanggilan antrian di sini
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pemanggilan Antrian'),
                          content: Text('Memanggil ${item.name}'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Tutup'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Panggil'),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // Tambahkan logika pemanggilan antrian di sini
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pemanggilan Antrian'),
                          content: Text('Memanggil ${item.name}'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Tutup'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Recall'),
                ),
              ],
            ),
          ),
        ]);
      }).toList(),
    );
  }
}
