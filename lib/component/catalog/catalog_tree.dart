import 'dart:developer';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart' as tree;
import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/home.dart';

class CatalogTree extends StatelessWidget {
  const CatalogTree({super.key, required this.catalogs});
  final List<Catalog> catalogs;

  tree.TreeNode<dynamic> _tree() {
    final root = tree.TreeNode.root();
    for (var catalog in catalogs) {
      // catalog
      final node = tree.TreeNode(key: catalog.name, data: catalog);
      root.add(node);
      // catalog -> blueprint
      var index = 0;
      for (var blueprint in catalog.blueprints) {
        index += 1;
        final blueprintNode =
            tree.TreeNode(key: '$index ${blueprint.name}', data: blueprint);
        node.add(blueprintNode);
      }
    }
    return root;
  }

  @override
  Widget build(BuildContext context) {
    return TreeView.simple(
      tree: _tree(),
      indentation: const Indentation(width: 0),
      expansionIndicatorBuilder: (context, node) {
        return ChevronIndicator.rightDown(
          alignment: Alignment.centerLeft,
          tree: node,
          color: material.Colors.white,
          icon: material.Icons.arrow_right,
        );
      },
      showRootNode: false,
      builder: (
        context,
        node,
      ) {
        final treeTheme = TreeTheme.of(context);
        final buttonThemeData = ButtonThemeData(
          color: treeTheme.color,
          hoverColor: treeTheme.hoverColor,
          highlightColor: treeTheme.highlightColor,
        );
        final title = node.key;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Button(
                bodyPadding: EdgeInsets.zero,
                theme: buttonThemeData,
                padding: EdgeInsets.zero,
                body: Text(
                  title,
                  style: Theme.of(context).treeTheme.textStyle,
                ),
                onPressed: () {
                  log('Tap $title');
                  final viewModel = context.read<HomeViewModel>();
                  viewModel.sidebarNodeTap(node);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
