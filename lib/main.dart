import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keeper/Controllers/theme_controller.dart';
import 'package:keeper/Model/notes.dart';
import 'package:keeper/Model/person.dart';
import 'package:keeper/Model/task.dart';
import 'package:keeper/Service/db_repository.dart';

import 'Pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Person>(PersonAdapter());
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Notes>(NotesAdapter());
  await DbRepository.openPersonBox();
  await DbRepository.openNotesbox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyTheme controller = Get.put(MyTheme());
    return Obx(
      () {
        return MaterialApp(
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
          themeMode: controller.getThemeMode(),
          theme: controller.ligthTheme,
          darkTheme: controller.darkTheme,
        );
      }
    );
  }
}
