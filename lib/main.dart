import 'package:antrian_app/constants.dart';
import 'package:antrian_app/core.dart';
import 'package:antrian_app/my_app.dart';
import 'package:antrian_app/shared/util/q_scrool_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
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
