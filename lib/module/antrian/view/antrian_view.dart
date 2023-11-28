import 'package:antrian_app/module/antrian/widget/test_video.dart';
import 'package:flutter/material.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_player/video_player.dart';

class AntrianView extends StatelessWidget {
  const AntrianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AntrianController>(
      init: AntrianController(),
      builder: (controller) {
        controller.view = this;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight: MediaQuery.sizeOf(context).height * 0.042,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                tabs: [
                  Tab(
                      child: Text(
                    'Gambar Layar Beranda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Tab(
                      child: Text(
                    'Video Layar Antrian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
              actions: const [],
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  height: 100.0,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.46,
                                width: MediaQuery.sizeOf(context).width * 0.38,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: controller.capturedImage != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: const Text(
                                                "Ambil Gambar",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              // height: 100.0,
                                              // width: 100,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.38,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.34,
                                                    child: Image.file(controller
                                                        .capturedImage!),
                                                  ),
                                                  Positioned(
                                                    bottom: 190,
                                                    left: 220,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .doDelete(true);
                                                        },
                                                        icon: Icon(
                                                          MdiIcons.closeCircle,
                                                          color: Colors.red,
                                                          size: 30.0,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // const SizedBox(
                                              //   height: 20.0,
                                              // ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: const Text(
                                                  "Ambil Gambar",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40.0,
                                              ),
                                              Container(
                                                // width: 100,
                                                // height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.pickImage();
                                                  },
                                                  icon: Icon(
                                                    color: Colors.grey,
                                                    MdiIcons.imagePlus,
                                                    size: 84,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              // ElevatedButton.icon(
                                              //   icon: const Icon(Icons.add),
                                              //   label: const Text("Add"),
                                              //   style: ElevatedButton.styleFrom(
                                              //     backgroundColor: Colors.blueGrey,
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius:
                                              //           BorderRadius.circular(12),
                                              //     ),
                                              //   ),
                                              //   onPressed: () {},
                                              // ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.upload_file),
                                label: const Text("Uploud"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  controller.postImage();
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.46,
                                width: MediaQuery.sizeOf(context).width * 0.38,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: const Text(
                                              "Layar Beranda",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          // height: 100.0,
                                          // width: 100,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              // Image.file(
                                              //     controller.capturedImage!),
                                              Image.network(
                                                media?['link'] ??
                                                    "https://i.ibb.co/S32HNjD/no-image.jpg",
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.34,
                                                fit: BoxFit.fill,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),

                              // ElevatedButton.icon(
                              //   icon: const Icon(Icons.add),
                              //   label: const Text("Add"),
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.blueGrey,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //   ),
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 100.0,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.51,
                                width: MediaQuery.sizeOf(context).width * 0.38,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: controller.captureVideo != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: const Text(
                                                "Ambil Video",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.38,
                                                    height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.38 *
                                                        9 /
                                                        16, // Mengasumsikan rasio aspek 16:9
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: AspectRatio(
                                                      aspectRatio: controller
                                                          .controllerVideoUploud!
                                                          .value
                                                          .aspectRatio,
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: <Widget>[
                                                          VideoPlayer(controller
                                                              .controllerVideoUploud!),
                                                          ClosedCaption(
                                                            text: controller
                                                                .controllerVideoUploud!
                                                                .value
                                                                .caption
                                                                .text,
                                                          ),
                                                          ControlsOverlay(
                                                            controller: controller
                                                                .controllerVideoUploud!,
                                                          ),
                                                          VideoProgressIndicator(
                                                            controller
                                                                .controllerVideoUploud!,
                                                            allowScrubbing:
                                                                true,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 190,
                                                    left: 220,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .doDeleteVideo(
                                                                true);
                                                      },
                                                      icon: Icon(
                                                        MdiIcons.closeCircle,
                                                        color: Colors.red,
                                                        size: 30.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // const SizedBox(
                                              //   height: 20.0,
                                              // ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: const Text(
                                                  "Ambil Video",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40.0,
                                              ),
                                              Container(
                                                // width: 100,
                                                // height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.pickVideo();
                                                  },
                                                  icon: Icon(
                                                    color: Colors.grey,
                                                    MdiIcons.videoPlus,
                                                    size: 84,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              // ElevatedButton.icon(
                                              //   icon: const Icon(Icons.add),
                                              //   label: const Text("Add"),
                                              //   style: ElevatedButton.styleFrom(
                                              //     backgroundColor: Colors.blueGrey,
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius:
                                              //           BorderRadius.circular(12),
                                              //     ),
                                              //   ),
                                              //   onPressed: () {},
                                              // ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.upload_file),
                                label: const Text("Uploud"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  controller.postVideo();
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.51,
                                width: MediaQuery.sizeOf(context).width * 0.38,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: const Text(
                                        "Layar Antrian",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38 *
                                                9 /
                                                16, // Mengasumsikan rasio aspek 16:9
                                            padding: const EdgeInsets.all(20),
                                            child: AspectRatio(
                                              aspectRatio: controller
                                                  .controllerVideoSupabase!
                                                  .value
                                                  .aspectRatio,
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: <Widget>[
                                                  VideoPlayer(controller
                                                      .controllerVideoSupabase!),
                                                  ClosedCaption(
                                                    text: controller
                                                        .controllerVideoSupabase!
                                                        .value
                                                        .caption
                                                        .text,
                                                  ),
                                                  ControlsOverlay(
                                                    controller: controller
                                                        .controllerVideoSupabase!,
                                                  ),
                                                  VideoProgressIndicator(
                                                    controller
                                                        .controllerVideoSupabase!,
                                                    allowScrubbing: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // const BumbleBeeRemoteVideo()

                // HomePage()
              ],
            ),
          ),
        );
      },
    );
  }
}

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay({super.key, required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: PopupMenuButton<Duration>(
        //     initialValue: controller.value.captionOffset,
        //     tooltip: 'Caption Offset',
        //     onSelected: (Duration delay) {
        //       controller.setCaptionOffset(delay);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<Duration>>[
        //         for (final Duration offsetDuration in _exampleCaptionOffsets)
        //           PopupMenuItem<Duration>(
        //             value: offsetDuration,
        //             child: Text('${offsetDuration.inMilliseconds}ms'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
        //     ),
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (double speed) {
        //       controller.setPlaybackSpeed(speed);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<double>>[
        //         for (final double speed in _examplePlaybackRates)
        //           PopupMenuItem<double>(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
