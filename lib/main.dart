import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:train_map/database/objectbox.dart';
import 'package:train_map/home.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesktopApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: PrimaryColors.deepSkyBlue.primaryColor,
      ),
      home: Container(
        // set background to prevent beep sound when tap on empty area (mac only)
        decoration: const BoxDecoration(color: material.Colors.white),
        child: const Home(),
      ),
    );
  }
}
