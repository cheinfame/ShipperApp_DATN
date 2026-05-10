import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:packare_shipper/data/services/api/websocket_service.dart';
import 'package:packare_shipper/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/themes/color_schemes.g.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'utils/location_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  
  
  // setup dependency injection locator
  await setupLocator();
  
  await requestLocationPermission();

  FlutterForegroundTask.initCommunicationPort();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      routerConfig: _appRouter.config(),
    );
  }
}
