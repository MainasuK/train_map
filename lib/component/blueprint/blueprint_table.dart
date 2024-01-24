import 'package:desktop/desktop.dart';
import 'package:train_map/component/blueprint/blueprint_view.dart';
import 'package:train_map/database/schemas.dart';

class BlueprintTable extends StatelessWidget {
  const BlueprintTable({
    super.key,
    required this.catalogs,
    required this.blueprints,
  });

  final List<Catalog> catalogs;
  final List<Blueprint> blueprints;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.shade[40];
    final borderSide = BorderSide(color: borderColor, width: 1.0);
    final tableHeaderNames = ['图册名称'] + BlueprintExtension.tableHeaderNames;

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
              tableHeaderNames.elementAtOrNull(col) ?? "",
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
      rows: List.generate(blueprints.length, (row) {
        return ListTableRow(
          onPressed: (position) async {
            await Dialog.showDialog(
              context,
              title: Text(blueprints[row].name),
              body: BlueprintView(blueprint: blueprints[row]),
            );
          },
          builder: (context, col) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SelectableText(
                text(
                      catalogs.elementAtOrNull(row),
                      blueprints[row],
                      col,
                    ) ??
                    "",
              ),
            );
          },
        );
      }),
    );
  }

  String? text(Catalog? catalog, Blueprint blueprint, int col) {
    switch (col) {
      case 0:
        return catalog?.name;
      case 1:
        return blueprint.index;
      case 2:
        return blueprint.code;
      case 3:
        return blueprint.name;
      case 4:
        return blueprint.remark;
      default:
        return null;
    }
  }
}
