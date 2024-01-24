import 'package:desktop/desktop.dart';
import 'package:train_map/control/copy_text_button.dart';
import 'package:train_map/database/schemas.dart';

class BlueprintView extends StatelessWidget {
  const BlueprintView({
    super.key,
    required this.blueprint,
  });

  final Blueprint blueprint;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 8.0,
      children: [
        Row(
          children: [
            const Text('图册名称: '),
            CopyTextButton(blueprint.name, context: context),
          ],
        ),
        Row(
          children: [
            const Text('总成编号: '),
            CopyTextButton(blueprint.index, context: context),
          ],
        ),
        Row(
          children: [
            const Text('备件图号: '),
            CopyTextButton(blueprint.code, context: context),
          ],
        ),
        Row(
          children: [
            const Text('名称: '),
            CopyTextButton(blueprint.name, context: context),
          ],
        ),
        Row(
          children: [
            const Text('备注: '),
            CopyTextButton(blueprint.remark, context: context),
          ],
        ),
      ],
    );
  }
}
