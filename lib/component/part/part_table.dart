import 'dart:developer';

import 'package:desktop/desktop.dart';
import 'package:provider/provider.dart';
import 'package:train_map/component/part/part_view.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/home.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart' as tree;

class PartTable extends StatelessWidget {
  const PartTable({
    super.key,
    required this.parts,
    this.isBlueprintInfoDisplay = false,
  });

  final List<Part> parts;
  final bool isBlueprintInfoDisplay;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.shade[40];
    final borderSide = BorderSide(color: borderColor, width: 1.0);
    final tableHeaderNames = isBlueprintInfoDisplay
        ? PartExtension.tableHeaderNames + BlueprintExtension.tableHeaderNames
        : PartExtension.tableHeaderNames;

    return ListTable(
      colCount: tableHeaderNames.length,
      allowColumnDragging: true,
      tableBorder: TableBorder(
        bottom: borderSide,
        top: borderSide,
        left: borderSide,
        right: borderSide,
        horizontalInside: borderSide,
      ),
      header: ListTableHeader(
        columnBorder: borderSide,
        builder: (context, col) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              tableHeaderNames[col],
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
      rows: List.generate(parts.length, (row) {
        return ListTableRow(
          onPressed: (position) async {
            await Dialog.showDialog(
              context,
              title: Text(parts[row].name),
              body: PartView(part: parts[row]),
            );
          },
          builder: (context, col) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: cell(context, parts[row], col),
            );
          },
        );
      }),
    );
  }

  Widget cell(BuildContext context, Part part, int col) {
    switch (col) {
      case 0:
        return SelectableText(part.index);
      case 1:
        return SelectableText(part.code);
      case 2:
        return SelectableText(part.name);
      case 3:
        return SelectableText(part.importCode);
      case 4:
        return SelectableText(part.domesticCode);
      case 5:
        return SelectableText(part.count);
      case 6:
        return SelectableText(part.remark);
      case 7:
        return SelectableText(part.blueprint.firstOrNull?.index ?? "");
      case 8:
        return SelectableText(part.blueprint.firstOrNull?.code ?? "");
      case 9:
        final text = part.blueprint.firstOrNull?.name ?? "";
        if (text.isNotEmpty) {
          return Row(
            children: [
              SelectableText(part.blueprint.firstOrNull?.name ?? ""),
              Button(
                body: const Text('➔'),
                onPressed: () {
                  log('Tap 打开');
                  final viewModel = context.read<HomeViewModel>();
                  final blueprint = part.blueprint.firstOrNull;
                  final node = tree.TreeNode(data: blueprint);
                  viewModel.sidebarNodeTap(node);
                },
              ),
            ],
          );
        } else {
          return SelectableText(text);
        }
      case 10:
        return SelectableText(part.blueprint.firstOrNull?.remark ?? "");
      default:
        return const Text("");
    }
  }
}
