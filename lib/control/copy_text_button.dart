import 'package:desktop/desktop.dart';
import 'package:flutter/services.dart';

class CopyTextButton extends Button {
  CopyTextButton(
    String text, {
    Key? key,
  }) : super(
          key: key,
          body: Text(text),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
          },
        );
}
