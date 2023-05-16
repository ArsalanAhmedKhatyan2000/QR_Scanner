import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matz/screens/survey/qrcode_scanner.dart';
import 'package:provider/provider.dart';

import 'controller.dart/information_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => InformationController()),
            ],
            child: MaterialApp(
              title: 'Matz',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue),
              home: const QRCodeScannerScreen(),
            ),
          );
        });
  }
}
