import 'package:flutter/material.dart';

class FirstBoxPickQueue extends StatelessWidget {
  final String nomorAntrian;
  final String layanan;
  final String loket;
  const FirstBoxPickQueue({
    Key? key,
    required this.nomorAntrian,
    required this.layanan,
    required this.loket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Now Serving",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey[900]!,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      nomorAntrian,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        layanan,
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        loket,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
