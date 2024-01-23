import 'dart:io';
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:d4_dsv/d4_dsv.dart';
import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:train_map/component/blueprint/blueprint_table.dart';
import 'package:train_map/control/padding.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/component/part/part_table.dart';
import 'package:train_map/main.dart' as main;

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _StartPageViewModel(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        controller: scrollController,
        child: scrollContentView(),
      ),
    );
  }

  Widget scrollContentView() {
    return Builder(
      builder: (context) {
        final viewModel = context.watch<_StartPageViewModel>();
        return Column(
          children: [
            catalogAndBlueprintTextField(context),
            partTextField(context),
            blueprintGallery(context),
            Row(
              children: [
                blueprintPhotoPickButton(context),
              ],
            ),
            BlueprintTable(
              catalogs: viewModel.catalogs,
              blueprints: viewModel.blueprints,
            ),
            PartTable(
              parts: viewModel.parts,
            ),
            Row(
              children: [
                createBlueprintButton(context),
              ],
            ),
          ].map(PaddingExtension.padding).toList(),
        );
      },
    );
  }

  TextField catalogAndBlueprintTextField(BuildContext context) {
    final viewModel = context.watch<_StartPageViewModel>();

    return TextField(
      autocorrect: false,
      placeholder: "图册名称	总成编号	备件图号	名称	备注",
      minLines: 4,
      maxLines: 4,
      onChanged: (value) {
        List<Catalog> catalogs = [];
        List<Blueprint> blueprints = [];

        final tsv = tsvParse(value);
        for (var map in tsv.$1) {
          final catalogName = map['图册名称'] ?? "";
          if (catalogName.isNotEmpty) {
            final oldCatalog = main.App.realm.find<Catalog>(catalogName);
            if (oldCatalog != null) {
              catalogs.add(oldCatalog);
            } else {
              final catalog = Catalog(catalogName);
              catalogs.add(catalog);
            }
          }

          final blueprint = Blueprint(
            ObjectId(),
            map['总成编号'] ?? "",
            map['备件图号'] ?? "",
            map['名称'] ?? "",
            map['备注'] ?? "",
          );
          blueprints.add(blueprint);
        }

        viewModel.updateCatalogs(
          catalogs.take(1).toList(),
        );
        viewModel.updateBlueprints(
          blueprints.take(1).toList(),
        );
      },
    );
  }

  TextField partTextField(BuildContext context) {
    final viewModel = context.watch<_StartPageViewModel>();

    return TextField(
      autocorrect: false,
      placeholder: "代号	物资编码	零件名称	进口零件号	国产零件号	本总成数量	备注",
      minLines: 10,
      maxLines: 10,
      onChanged: (value) {
        List<Part> parts = [];

        final tsv = tsvParse(value);
        for (var map in tsv.$1) {
          final part = Part(
            ObjectId(),
            map['代号'] ?? "",
            map['物资编码'] ?? "",
            map['零件名称'] ?? "",
            map['进口零件号'] ?? "",
            map['国产零件号'] ?? "",
            map['本总成数量'] ?? "",
            map['备注'] ?? "",
          );
          parts.add(part);
        }

        viewModel.updateParts(parts);
      },
    );
  }

  Button blueprintPhotoPickButton(BuildContext context) {
    final viewModel = context.watch<_StartPageViewModel>();

    return Button(
      body: const Text('添加图纸'),
      onPressed: () async {
        log('添加图纸');
        await viewModel.pickBlueprintPhoto();
      },
    );
  }

  Widget blueprintGallery(BuildContext context) {
    final viewModel = context.watch<_StartPageViewModel>();

    if (viewModel.files.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 150 + 16,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 16.0),
        itemCount: viewModel.files.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return blueprintItem(context, index);
        },
      ),
    );
  }

  Widget blueprintItem(BuildContext context, int index) {
    final viewModel = context.watch<_StartPageViewModel>();
    final file = viewModel.files[index];

    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: material.Colors.grey,
              width: 1,
            ),
          ),
          child: Image.file(
            File(file.path),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 1,
          bottom: 10,
          child: Button(
            theme: ButtonThemeData(
              foreground: material.Colors.red,
              hoverForeground: material.Colors.white,
              background: material.Colors.white,
              hoverBackground: material.Colors.red[800],
              highlightForeground: material.Colors.white,
              highlightBackground: material.Colors.red[600],
            ),
            body: const Text('删除'),
            filled: true,
            onPressed: () {
              log('删除图纸 $index');
              viewModel.deleteBlueprintPhotoAt(index);
            },
          ),
        ),
        Builder(
          builder: ((context) {
            if (index > 0) {
              return Positioned(
                right: 1,
                bottom: 10,
                child: Button(
                  theme: ButtonThemeData(
                    foreground: material.Colors.blue,
                    hoverForeground: material.Colors.white,
                    background: material.Colors.white,
                    hoverBackground: material.Colors.blue[800],
                    highlightForeground: material.Colors.white,
                    highlightBackground: material.Colors.blue[600],
                  ),
                  body: const Text('左移'),
                  filled: true,
                  onPressed: () {
                    log('左移图纸 $index');
                    viewModel.leftMoveBlueprintPhotoAt(index);
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ],
    );
  }

  Button createBlueprintButton(BuildContext context) {
    final viewModel = context.watch<_StartPageViewModel>();

    return Button(
      body: const Text('创建图纸'),
      onPressed: () {
        viewModel.create(context);
      },
    );
  }
}

class _StartPageViewModel extends ChangeNotifier {
  // input
  final ImagePicker _picker = ImagePicker();
  final realm = main.App.realm;

  // output
  List<Catalog> catalogs = [];
  List<Blueprint> blueprints = [];
  List<Part> parts = [];
  List<XFile> files = [];

  _StartPageViewModel() {
    // do nothing
  }

  void updateCatalogs(List<Catalog> catalogs) {
    this.catalogs = catalogs;
    notifyListeners();
  }

  void updateBlueprints(List<Blueprint> blueprints) {
    this.blueprints = blueprints;
    notifyListeners();
  }

  void updateParts(List<Part> parts) {
    this.parts = parts;
    notifyListeners();
  }

  Future<void> pickBlueprintPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      files.add(pickedFile);
      log('添加图纸：${pickedFile.path}');
      notifyListeners();
    }
  }

  void deleteBlueprintPhotoAt(int index) {
    files.removeAt(index);
    notifyListeners();
  }

  void leftMoveBlueprintPhotoAt(int index) {
    if (index > 0) {
      final file = files[index];
      files.removeAt(index);
      files.insert(index - 1, file);
      notifyListeners();
    }
  }

  void create(BuildContext context) {
    // check catalog
    final catalog = catalogs.firstOrNull;
    if (catalog == null) {
      Messenger.clearMessages(context);
      Messenger.showMessage(
        context,
        message: '创建图册失败：缺少图册名称',
        kind: MessageKind.warning,
      );
      return;
    }

    // check blueprint
    final blueprint = blueprints.firstOrNull;
    if (blueprint == null || blueprint.name.isEmpty) {
      Messenger.clearMessages(context);
      Messenger.showMessage(
        context,
        message: '创建图册失败：缺少图纸名称',
        kind: MessageKind.warning,
      );
      return;
    }

    // check parts
    final parts = this.parts;
    if (parts.isEmpty) {
      Messenger.clearMessages(context);
      Messenger.showMessage(
        context,
        message: '创建图册失败：缺少零件信息',
        kind: MessageKind.warning,
      );
      return;
    }

    // // XFiles to UInt8Lists
    // final files = this.files;
    // files.map { (file) {
    //   final bytes = await file.
    //   return bytes;
    // }}

    realm.write(() {
      // catalog
      realm.add(catalog, update: true);

      // blueprint
      List<Uint8List> images = [];
      for (final xfile in files) {
        final file = File(xfile.path);
        final bytes = file.readAsBytesSync();
        images.add(bytes);
      }
      blueprint.images.addAll(images);
      catalog.blueprints.add(blueprint);

      // part
      blueprint.parts.addAll(parts);
    });
  }
}
