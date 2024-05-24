import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'constant/box_constant.dart';
import 'firebase_options.dart';
import 'model/hive_order/hive_order_model.dart';
import 'presentation/login/login.dart';

Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
   //await boxHive();
  await windowManager.ensureInitialized();
   await GetStorage.init();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(850, 650));
    WindowManager.instance.setMaximumSize(const Size(850, 650));
  }
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));

}

BoxContants boxContants = BoxContants();

Future <void> boxHive() async{
  
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  // user box
  Hive.registerAdapter(HiveOrderModelAdapter());
  await Hive.openBox<HiveOrderModel>(boxContants.userBox);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
