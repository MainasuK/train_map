import 'package:desktop/desktop.dart';

class NewDesktopLocalizationsDelegate
    extends LocalizationsDelegate<DesktopLocalizations> {
  @override
  bool isSupported(Locale locale) {
    if (locale.languageCode == 'zh') {
      return true;
    }
    if (locale.languageCode == 'en') {
      return true;
    }
    return false;
  }

  @override
  Future<DesktopLocalizations> load(Locale locale) {
    return DefaultDesktopLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DesktopLocalizations> old) {
    return false;
  }
}
