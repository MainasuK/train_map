import 'package:desktop/desktop.dart';
import 'package:flutter/services.dart';

class CopyTextButton extends Button {
  CopyTextButton(
    String text, {
    super.key,
    String title = '',
    required BuildContext context,
  }) : super(
          body: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.shade[100]),
                ),
                TextSpan(text: text),
                const WidgetSpan(child: Icon(Icons.copy)),
              ],
            ),
          ),
          onPressed: () async {
            Clipboard.setData(ClipboardData(text: text));
            Messenger.clearMessages(context);
            Messenger.showMessage(context,
                message: '复制到剪切板：$text', kind: MessageKind.info);
          },
        );
}
