// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MContainerLayer extends StatelessWidget {
  final String loket;
  final String kode;
  final double margin;

  const MContainerLayer({
    Key? key,
    required this.loket,
    required this.kode,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.width < 850;
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
            height: 20.0,
          ),
          Expanded(
            flex: 2,
            child: Text(
              loket,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 20 : 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              kode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 50 : 100.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
