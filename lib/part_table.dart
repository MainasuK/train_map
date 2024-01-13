import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:train_map/control/copy_text_button.dart';
import 'package:train_map/database/part.dart';
import 'package:train_map/defaults.dart';

class PartTable extends StatelessWidget {
  const PartTable({
    Key? key,
    required this.parts,
  }) : super(key: key);

  final List<Part> parts;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.shade[40];
    final borderSide = BorderSide(color: borderColor, width: 1.0);
    final tableHeaderNames = [
      '序号',
      '物资编码',
      '零件名称',
      '进口零件号',
      '国产零件号',
      '本总成数量',
      '备注'
    ];

    return ListTable(
      colCount: 7,
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
              child: Text(
                text(parts[row], col),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        );
      }),
    );
  }

  String text(Part part, int col) {
    switch (col) {
      case 0:
        return part.index;
      case 1:
        return part.code;
      case 2:
        return part.name;
      case 3:
        return part.importCode;
      case 4:
        return part.domesticCode;
      case 5:
        return part.count;
      case 6:
        return part.remark;
      default:
        return "";
    }
  }
}

class PartView extends StatelessWidget {
  const PartView({
    Key? key,
    required this.part,
  }) : super(key: key);

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
            CopyTextButton(part.index),
          ],
        ),
        Row(
          children: [
            const Text('物资编码: '),
            CopyTextButton(part.code),
          ],
        ),
        Row(
          children: [
            const Text('零件名称: '),
            CopyTextButton(part.name),
          ],
        ),
        Row(
          children: [
            const Text('进口零件号: '),
            CopyTextButton(part.importCode),
          ],
        ),
        Row(
          children: [
            const Text('国产零件号: '),
            CopyTextButton(part.domesticCode),
          ],
        ),
        Row(
          children: [
            const Text('本总成数量: '),
            CopyTextButton(part.count),
          ],
        ),
        Row(
          children: [
            const Text('备注: '),
            CopyTextButton(part.remark),
          ],
        ),
      ],
    );
  }
}
