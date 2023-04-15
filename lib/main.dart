import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasky_track/introduction/presentation/introduction_page.dart';
import 'core/widgets/app_widget.dart';

const primaryColor = Color.fromARGB(255, 38, 187, 11);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TaskyTrack',
        home: AppWidget(),
      ),
    );
  }
}
