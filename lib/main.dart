import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/utils/constants.dart';
import 'ui/screens/game_screen.dart';
// ignore: unused_import
import 'ui/screens/main_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to Landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Enable immersive mode for mobile gaming
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const IronFrontierApp());
}

class IronFrontierApp extends StatelessWidget {
  const IronFrontierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRON FRONTIER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GameConstants.colorAbyssalNavy,
        fontFamily: 'monospace',
      ),
      home: const GameScreen(),
    );
  }
}
