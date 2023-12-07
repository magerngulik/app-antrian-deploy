import 'dart:io';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class AntrianController extends GetxController {
  AntrianView? view;

  File? capturedImage;
  VideoPlayerController? controllerVideoUploud;
  VideoPlayerController? _toBeDisposed;
  VideoPlayerController? controllerVideoSupabase;
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
      videoPath.value = '';
      _disposeVideoController();
      _toBeDisposed!.dispose();
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

  Future<String?> uploudVideo() async {
    if (videoUploud == null) {
      return null;
    }
    var uuid = const Uuid();
    captureVideo = File(videoUploud!.path);
    final fileExt = videoUploud!.path.split('.').last;
    final fileName = '${uuid.v4()}$fileExt';
    final filePath = 'video/$fileName';
    final response = await supabase.storage
        .from('configuration')
        .upload(filePath, captureVideo!);

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

  postVideo() async {
    Get.dialog(const LoadingScreen(), barrierDismissible: false);

    try {
      final videoNew = await uploudVideo();
      await supabase.from('configuration').insert({
        "type_configuration": 'video',
        "link": videoNew,
      });
      Get.dialog(const AlertDialogNotif(
          title: 'Uploud Succes', srcImages: 'assets/images/notif_succes.png'));
      await Future.delayed(const Duration(seconds: 2));
      Get.back(closeOverlays: true);
      await doDeleteVideo(true);
      await getMediaVideo();
      controllerVideoSupabase = VideoPlayerController.networkUrl(
        Uri.parse(mediaVideo!['link']),
        // closedCaptionFile: _loadCaptions(),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      controllerVideoSupabase!.addListener(() {
        update();
      });
      controllerVideoSupabase!.setLooping(true);
      controllerVideoSupabase!.initialize();
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

  getMediaVideo() async {
    mediaVideo = await SupabaseSevice().getMediaVideo();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controllerVideoSupabase = VideoPlayerController.networkUrl(
      Uri.parse(mediaVideo!['link']),
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    controllerVideoSupabase!.addListener(() {
      update();
    });
    controllerVideoSupabase!.setLooping(true);
    controllerVideoSupabase!.initialize();
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
    super.dispose();
    doDeleteVideo(true);
    controllerVideoSupabase!.dispose();
    controllerVideoUploud!.dispose();
    _toBeDisposed!.dispose();
    _disposeVideoController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    doDeleteVideo(true);
    controllerVideoUploud!.dispose();
    _toBeDisposed!.dispose();
    _disposeVideoController();
  }
}
