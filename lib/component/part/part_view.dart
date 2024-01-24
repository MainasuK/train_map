import 'package:desktop/desktop.dart';
import 'package:train_map/control/copy_text_button.dart';
import 'package:train_map/database/schemas.dart';

class PartView extends StatelessWidget {
  const PartView({
    super.key,
    required this.part,
  });

  final Part part;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 8.0,
      children: [
        Row(
          children: [
            const Text('序号: '),
            CopyTextButton(part.index, context: context),
          ],
        ),
        Row(
          children: [
            const Text('物资编码: '),
            CopyTextButton(part.code, context: context),
          ],
        ),
        Row(
          children: [
            const Text('零件名称: '),
            CopyTextButton(part.name, context: context),
          ],
        ),
        Row(
          children: [
            const Text('进口零件号: '),
            CopyTextButton(part.importCode, context: context),
          ],
        ),
        Row(
          children: [
            const Text('国产零件号: '),
            CopyTextButton(part.domesticCode, context: context),
          ],
        ),
        Row(
          children: [
            const Text('本总成数量: '),
            CopyTextButton(part.count, context: context),
          ],
        ),
        Row(
          children: [
            const Text('备注: '),
            CopyTextButton(part.remark, context: context),
          ],
        ),
      ],
    );
  }
}
