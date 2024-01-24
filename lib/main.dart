import 'dart:developer';

import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:realm/realm.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/home.dart';
import 'package:train_map/vendor/desktop_l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup realm
  final realmConfiguration = Configuration.local(
    [Catalog.schema, Blueprint.schema, Part.schema],
    // shouldDeleteIfMigrationNeeded: true,
  );
  log('setup realm at path: ${realmConfiguration.path}');
  App.realm = Realm(realmConfiguration);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static late Realm realm;

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
      supportedLocales: const [
        Locale.fromSubtags(
            languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
      ],
      localizationsDelegates: [
        NewDesktopLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
