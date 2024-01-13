import 'package:d4_dsv/d4_dsv.dart';
import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:train_map/main.dart';
import 'package:train_map/database/blueprint.dart';
import 'package:train_map/database/part.dart';
import 'package:train_map/part_table.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final scrollController = ScrollController();
  final blurprintIndexController = TextEditingController();
  final blurprintCodeController = TextEditingController();
  final blurprintNameController = TextEditingController();
  final blurprintRemarkController = TextEditingController();

  List<Part> parts = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      controller: scrollController,
      child: Column(
        children: [
          TextField(
            autocorrect: false,
            placeholder: "总成编号",
            controller: blurprintIndexController,
          ),
          TextField(
            autocorrect: false,
            placeholder: "备件图号",
            controller: blurprintCodeController,
          ),
          TextField(
            autocorrect: false,
            placeholder: "名称",
            controller: blurprintNameController,
          ),
          TextField(
            autocorrect: false,
            placeholder: "备注",
            controller: blurprintRemarkController,
          ),
          TextField(
            autocorrect: false,
            placeholder: "代号	物资编码	零件名称	进口零件号	国产零件号	本总成数量	备注",
            minLines: 10,
            maxLines: 10,
            onChanged: (value) {
              List<Part> parts = [];

              final tsv = tsvParse(value);
              for (var map in tsv.$1) {
                final part = Part(
                  index: map['代号'] ?? "",
                  code: map['物资编码'] ?? "",
                  name: map['零件名称'] ?? "",
                  importCode: map['进口零件号'] ?? "",
                  domesticCode: map['国产零件号'] ?? "",
                  count: map['本总成数量'] ?? "",
                  remark: map['备注'] ?? "",
                );
                parts.add(part);
              }
              setState(() {
                this.parts = parts;
              });
            },
          ),
          Button(
            body: const Text('创建图纸'),
            onPressed: () {},
          ),
          PartTable(parts: parts),
        ].map(_StartPageState.padding).toList(),
      ),
    );
  }

  static Padding padding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: widget,
    );
  }

  void create() {
    final store = objectBox.store;
    final blueprintBox = store.box<Blueprint>();

    final blueprint = Blueprint(
      index: blurprintIndexController.text,
      code: blurprintCodeController.text,
      name: blurprintNameController.text,
      remark: blurprintRemarkController.text,
    );
  }
}
