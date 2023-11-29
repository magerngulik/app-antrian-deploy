import 'package:antrian_app/themes/color.dart';
import 'package:antrian_app/themes/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AlertDialogChoice extends StatelessWidget {
  String title;
  String desc;
  String positiveBtnText;
  String negativeBtnText;
  VoidCallback onTapPositiveBtn;
  VoidCallback? onTapNegativeBtn;
  AlertDialogChoice({
    required this.title,
    required this.desc,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onTapPositiveBtn,
    this.onTapNegativeBtn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        title,
        style: mediumStyleBlack.copyWith(fontSize: 19),
      ),
      content: Text(
        desc,
        style: regStyle.copyWith(
          fontSize: 13,
          color: const Color(0xff828282),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: (onTapNegativeBtn != null)
                ? onTapPositiveBtn
                : () => Get.back(closeOverlays: true),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: lightYellowColor,
            ),
            child: Text(
              negativeBtnText,
              style: regStyleBlack.copyWith(fontSize: 12),
            ),
          ),
        ),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: onTapPositiveBtn,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: lightBlueColor,
            ),
            child: Text(
              positiveBtnText,
              style: regStyleWhite.copyWith(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
