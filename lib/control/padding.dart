import 'package:desktop/desktop.dart';

extension PaddingExtension on Padding {
  static Padding padding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: widget,
    );
  }
}
