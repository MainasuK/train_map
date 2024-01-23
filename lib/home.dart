import 'dart:async';
import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:realm/realm.dart';
import 'package:train_map/component/catalog/catalog_tree.dart';
import 'package:train_map/control/copy_text_button.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/page/blueprint_page.dart';
import 'package:train_map/page/search_page.dart';
import 'package:train_map/page/start_page.dart';
import 'package:train_map/main.dart' as main;
import 'package:animated_tree_view/tree_view/tree_node.dart' as tree;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sidebar(),
          detail(),
        ],
      ),
    );
  }

  Widget sidebar() {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: PrimaryColors.deepSkyBlue.primaryColor,
      ),
      child: Builder(builder: (context) {
        final viewModel = context.watch<HomeViewModel>();
        return Container(
          color: Theme.of(context).colorScheme.background[0],
          child: SizedBox(
            width: 250,
            child: Column(
              children: [
                title(),
                start(),
                search(),
                Expanded(
                  child: CatalogTree(catalogs: viewModel.catalogs),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget detail() {
    return Expanded(
      child: Builder(builder: ((context) {
        final viewModel = context.watch<HomeViewModel>();
        return DetailView(
          kind: viewModel.kind,
          catalog: viewModel.catalog,
          blueprint: viewModel.blueprint,
        );
      })),
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          body: const Text('备件查询系统'),
          onPressed: () async {
            log('Tap 标题');

            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            final version = packageInfo.version;
            final build = packageInfo.buildNumber;

            if (!mounted) {
              return;
            }

            await Dialog.showDialog(
              context,
              title: const Text('关于'),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CopyTextButton(
                    'v$version ($build)',
                    title: '版本：',
                    context: context,
                  ),
                  CopyTextButton(
                    '${main.App.realm.config.path}',
                    title: '数据库存储：',
                    context: context,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget start() {
    return Builder(builder: (context) {
      final treeTheme = TreeTheme.of(context);
      final buttonThemeData = ButtonThemeData(
        color: treeTheme.color,
        hoverColor: treeTheme.hoverColor,
        highlightColor: treeTheme.highlightColor,
      );

      return Row(
        children: [
          Button(
            theme: buttonThemeData,
            body: const Text('开始'),
            onPressed: () {
              log("Tap 开始");
              final viewModel = context.read<HomeViewModel>();
              viewModel.updateHomeDetailPageKind(HomeDetailPageKind.start);
            },
          ),
        ],
      );
    });
  }

  Widget search() {
    return Builder(builder: (context) {
      final treeTheme = TreeTheme.of(context);
      final buttonThemeData = ButtonThemeData(
        color: treeTheme.color,
        hoverColor: treeTheme.hoverColor,
        highlightColor: treeTheme.highlightColor,
      );

      return Row(
        children: [
          Button(
            theme: buttonThemeData,
            body: const Text('查询'),
            onPressed: () {
              log("Tap 查询");
              final viewModel = context.read<HomeViewModel>();
              viewModel.updateHomeDetailPageKind(HomeDetailPageKind.search);
            },
          ),
        ],
      );
    });
  }
}

class HomeViewModel extends ChangeNotifier {
  // input
  final realm = main.App.realm;
  late StreamSubscription<RealmResultsChanges<Catalog>> catalogSubscription;

  // output
  List<Catalog> catalogs = [];

  HomeDetailPageKind kind = HomeDetailPageKind.start;
  Catalog? catalog;
  Blueprint? blueprint;

  HomeViewModel() {
    catalogs = realm.all<Catalog>().toList();
    catalogSubscription = main.App.realm.all<Catalog>().changes.listen((event) {
      catalogs = event.results.toList();
      notifyListeners();
    });
  }

  void updateHomeDetailPageKind(HomeDetailPageKind kind) {
    this.kind = kind;
    notifyListeners();
  }

  void sidebarNodeTap(tree.TreeNode<dynamic> node) {
    final data = node.data;

    catalog = null;
    blueprint = null;

    if (data is Catalog) {
      catalog = data;
      updateHomeDetailPageKind(HomeDetailPageKind.catalog);
    } else if (data is Blueprint) {
      blueprint = data;
      updateHomeDetailPageKind(HomeDetailPageKind.blueprint);
    }
  }
}

enum HomeDetailPageKind {
  start,
  search,
  catalog,
  blueprint;
}

class DetailView extends StatelessWidget {
  final HomeDetailPageKind kind;
  final Catalog? catalog;
  final Blueprint? blueprint;

  const DetailView({
    Key? key,
    required this.kind,
    this.catalog,
    required this.blueprint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget view = this.view(context);
    return view;
  }

  Widget view(BuildContext context) {
    switch (kind) {
      case HomeDetailPageKind.start:
        return const StartPage();
      case HomeDetailPageKind.search:
        return const SearchPage();
      case HomeDetailPageKind.catalog:
        if (catalog != null) {
          return const Center(child: Text("Catalog"));
        } else {
          return const Center(child: Text("Catalog"));
        }
      case HomeDetailPageKind.blueprint:
        if (blueprint != null) {
          return BlueprintPage(blueprint: blueprint!);
        } else {
          return const Center(child: Text("Blueprint"));
        }
      default:
        return const Center(child: Text("Unknown"));
    }
  }
}
