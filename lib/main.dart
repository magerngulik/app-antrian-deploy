import 'package:antrian_app/constants.dart';
import 'package:antrian_app/core.dart';
import 'package:antrian_app/my_app.dart';
import 'package:antrian_app/shared/services/supabase_service.dart';
import 'package:antrian_app/shared/util/q_scrool_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';

final supabase = Supabase.instance.client;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  media = await SupabaseSevice().getMedia();
  VideoPlayerMediaKit.ensureInitialized(
    android:
        true, // default: false    -    dependency: media_kit_libs_android_video
    iOS: true, // default: false    -    dependency: media_kit_libs_ios_video
    macOS:
        true, // default: false    -    dependency: media_kit_libs_macos_video
    windows:
        true, // default: false    -    dependency: media_kit_libs_windows_video
    linux: true, // default: false    -    dependency: media_kit_libs_linux
  );

  initializeDateFormatting('id_ID', null).then((_) => runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          title: 'Antrian App',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            canvasColor: canvasColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            textTheme: const TextTheme(
              headlineSmall: TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          home: const MyApp(),
        ),
      ));
}
