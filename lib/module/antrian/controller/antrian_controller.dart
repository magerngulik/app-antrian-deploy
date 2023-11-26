import 'dart:io';
import 'dart:math';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
import 'package:antrian_app/shared/services/supabase_service.dart';
import 'package:antrian_app/shared/util/loading_screen.dart';
import 'package:antrian_app/shared/widget/show_loading/dialog/alert_dialog_notif.dart';
import 'package:antrian_app/shared/widget/show_loading/show_loading.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../view/antrian_view.dart';

class AntrianController extends GetxController {
  AntrianView? view;

  File? capturedImage;
  VideoPlayerController? controllerVideoUploud;
  VideoPlayerController? _toBeDisposed;
  File? captureVideo;
  XFile? videoUploud;
  String? attachementVideo;
  var videoPath = ''.obs;

  XFile? image;
  String? attachement;
  var imagePath = ''.obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    capturedImage = File(image!.path);
    update();
    Get.back();
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    videoUploud = await picker.pickVideo(source: ImageSource.gallery);

    if (videoUploud == null) {
      return;
    }
    captureVideo = File(videoUploud!.path);
    playVideo(captureVideo!);
    update();
    Get.back();
  }

  doDelete(bool isDelete) {
    if (isDelete) {
      capturedImage = null;
      attachementVideo = '';
    } else {
      imagePath.value = '';
    }
    update();
  }

  doDeleteVideo(bool isDelete) {
    if (isDelete) {
      captureVideo = null;
      attachement = '';
    } else {
      videoPath.value = '';
    }
    update();
  }

  Future<String?> uploudImage() async {
    if (image == null) {
      return null;
    }
    var uuid = const Uuid();
    capturedImage = File(image!.path);
    final fileExt = image!.path.split('.').last;
    final fileName = '${uuid.v4()}$fileExt';
    final filePath = 'image/$fileName';
    final response = await supabase.storage
        .from('configuration')
        .upload(filePath, capturedImage!);

    if (response.isEmpty) {
      return null;
    }

    final urlImage =
        supabase.storage.from('configuration').getPublicUrl(filePath);
    final filename = urlImage;

    return filename;
  }

  postImage() async {
    Get.dialog(const LoadingScreen(), barrierDismissible: false);

    try {
      final imageNew = await uploudImage();
      await supabase.from('configuration').insert({
        "type_configuration": 'image',
        "link": imageNew,
      });
      Get.dialog(const AlertDialogNotif(
          title: 'Uploud Succes', srcImages: 'assets/images/notif_succes.png'));
      await Future.delayed(const Duration(seconds: 2));
      Get.back(closeOverlays: true);
      await doDelete(true);
      await getMedia();
    } catch (e) {
      print('errornya$e');

      Get.dialog(const AlertDialogNotif(
          title: 'Uploud Failed', srcImages: 'assets/images/notif_failed.png'));
      await Future.delayed(const Duration(seconds: 2));
      Get.back(closeOverlays: true);
    }
  }

  getMedia() async {
    media = await SupabaseSevice().getMedia();

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // controllerVideoUploud =
    //     VideoPlayerController.file(File(captureVideo!.path));
    // controllerVideoUploud = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    //   // closedCaptionFile: _loadCaptions(),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );

    // controllerVideoUploud!.addListener(() {
    //   update();
    // });
    // controllerVideoUploud!.setLooping(true);
    // controllerVideoUploud!.initialize();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = controllerVideoUploud;
    controllerVideoUploud = null;
  }

  Future<void> playVideo(File? file) async {
    if (file != null) {
      await _disposeVideoController();
      late VideoPlayerController controller;

      // TODO(gabrielokura): remove the ignore once the following line can migrate to
      // use VideoPlayerController.networkUrl after the issue is resolved.
      // https://github.com/flutter/flutter/issues/121927
      // ignore: deprecated_member_use

      controller = VideoPlayerController.file(File(file.path));

      controllerVideoUploud = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      const double volume = 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      update();
    }
  }

  @override
  void dispose() {
    controllerVideoUploud!.dispose();
    super.dispose();
  }
}
