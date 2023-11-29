import 'package:antrian_app/themes/font_style.dart';
import 'package:flutter/material.dart';

class AlertDialogRadius extends StatelessWidget {
  final String srcImages;
  const AlertDialogRadius({
    required this.srcImages,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text(
        "Anda diluar radius",
        textAlign: TextAlign.center,
        style: mediumStyleBlack.copyWith(fontSize: 19),
      ),
      content: Image.asset(
        srcImages,
        height: 74,
        width: 74,
      ),
    );
  }
}
