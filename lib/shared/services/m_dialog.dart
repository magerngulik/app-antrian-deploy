// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MDialogError extends StatelessWidget {
  final Function() onTap;
  final String message;
  const MDialogError({
    Key? key,
    required this.onTap,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                size: 80,
                color: Colors.red,
              ),
              const Text(
                'Warning',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => onTap(),
                  child: const Text(
                    "Kembali",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MDialogLogout extends StatelessWidget {
  final Function() onTap;

  const MDialogLogout({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 80,
              color: Colors.red,
            ),
            Text(
              'Warning',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Apakah anda yakin ingin keluar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => onTap(),
          child: const Text("Yes"),
        ),
      ],
    );
  }
}

class MDialogSuccess extends StatelessWidget {
  final Function() onTap;
  final String message;
  const MDialogSuccess({
    Key? key,
    required this.onTap,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
            const Text(
              'Sucess',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => onTap(),
                child: const Text(
                  "Kembali",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MDialogTicket extends StatelessWidget {
  final Function() onTap;
  final String kode;
  final String tanggal;
  final String waktu;
  const MDialogTicket({
    Key? key,
    required this.onTap,
    required this.kode,
    required this.tanggal,
    required this.waktu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nomor Antrian',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Divider(),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              kode,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Divider(),
            const SizedBox(
              height: 15.0,
            ),
            // const Text(
            //   "Teler",
            //   style: TextStyle(
            //     fontSize: 25.0,
            //     color: Colors.grey,
            //   ),
            // ),
            Text(
              tanggal,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            Text(
              waktu,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => onTap(),
                child: const Text(
                  "Kembali",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
