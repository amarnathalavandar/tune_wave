import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tune_wave/features/home/home_screen.dart';
import 'package:tune_wave/features/home/splash_screen.dart';
import 'package:tune_wave/models/playlist_provider.dart';
import 'package:tune_wave/shared/theme/app_theme.dart';

import 'features/player/playlist.dart';

void main() {
  runApp( DevicePreview(
    isToolbarVisible: true,
    devices: [
      Devices.ios.iPhone12,
      Devices.ios.iPhone13,
      Devices.android.onePlus8Pro,
      Devices.android.samsungGalaxyA50,
      Devices.android.samsungGalaxyNote20Ultra,
    ],
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>PlaylistProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: const TWAppTheme().themeData,
        home:const SplashScreen(),
      ),
    );
  }
}

