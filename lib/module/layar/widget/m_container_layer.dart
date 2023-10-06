import 'package:flutter/material.dart';

class MContainerLayer extends StatelessWidget {
  final String loket;
  final String kode;
  final double margin;

  const MContainerLayer({
    super.key,
    required this.margin,
    required this.loket,
    required this.kode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.height / 2.5,
      margin: EdgeInsets.only(
        left: margin,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Color.fromARGB(255, 240, 172, 252),
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            32.0,
          ),
        ),
        border: Border.all(
          width: 20.0,
          color: Colors.grey[350]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Text(
            loket,
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            kode,
            style: const TextStyle(
              fontSize: 100.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
