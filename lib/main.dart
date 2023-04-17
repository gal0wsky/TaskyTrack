import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasky_track/introduction/presentation/introduction_page.dart';
import 'core/widgets/app_widget.dart';

const primaryColor = Color.fromARGB(255, 38, 187, 11);

const _introScreenStorageKey = 'introScreenShowed';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getNextPage(),
      builder: ((context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskyTrack',
            home: snapshot.data,
          );
        }
        else {
          return const CircularProgressIndicator();
        }
      })
    );
  }

  Future<Widget> _getNextPage() async {
    await GetStorage.init();
    final storage = GetStorage();

    final skipIntroduction = storage.read<bool>(_introScreenStorageKey) ?? false;

    if (skipIntroduction) {
      return AppWidget();
    }
    else {
      await storage.write(_introScreenStorageKey, true);
      return const IntroductionPage();
    }
  }
}
