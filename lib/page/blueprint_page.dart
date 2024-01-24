import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';
import 'package:train_map/component/blueprint/blueprint_table.dart';
import 'package:train_map/component/part/part_table.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/home.dart';
import 'package:train_map/main.dart' as main;

class BlueprintPage extends StatefulWidget {
  final Blueprint blueprint;

  const BlueprintPage({super.key, required this.blueprint});

  @override
  State<BlueprintPage> createState() => _BlueprintPageState();
}

class _BlueprintPageState extends State<BlueprintPage> {
  double minScale = 0.5;
  double maxScale = 4.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _BlueprintPageViewModel(widget.blueprint),
      child: MultiSplitViewTheme(
        data:
            MultiSplitViewThemeData(dividerPainter: DividerPainters.grooved1()),
        child: Builder(builder: (context) {
          final viewModel = context.watch<_BlueprintPageViewModel>();

          return MultiSplitView(
            axis: Axis.vertical,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Theme.of(context).colorScheme.shade[40],
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Button(
                          active: viewModel.isPreviousImageAvailable(),
                          body: const Text('上一张'),
                          onPressed: () {
                            developer.log('上一张');
                            viewModel.previousImage();
                          },
                        ),
                        Button(
                          active: viewModel.isNextImageAvailable(),
                          body: const Text('下一张'),
                          onPressed: () {
                            developer.log('下一张');
                            viewModel.nextImage();
                          },
                        ),
                        const Spacer(),
                        Button(
                          body: const Text('删除图纸'),
                          theme: ButtonThemeData(
                            color: material.Colors.red,
                            hoverColor: material.Colors.red[600],
                          ),
                          onPressed: () async {
                            developer.log('删除图纸');
                            viewModel.requestDelete(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: InteractiveViewer(
                      constrained: false,
                      minScale: minScale,
                      maxScale: maxScale,
                      child: _PhotoView(imageData: viewModel.image),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    BlueprintTable(
                      catalogs: widget.blueprint.catalog.toList(),
                      blueprints: [widget.blueprint],
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: PartTable(parts: widget.blueprint.parts),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _PhotoView extends StatelessWidget {
  final Uint8List? imageData;
  const _PhotoView({required this.imageData});

  @override
  Widget build(BuildContext context) {
    if (imageData != null) {
      final image = Image.memory(imageData!);
      return image;
    } else {
      return const Center(child: Text('无图片'));
    }
  }
}

class _BlueprintPageViewModel extends ChangeNotifier {
  // input
  final realm = main.App.realm;
  Blueprint blueprint;

  // output
  int indexOfImages;
  int countOfImages;
  Uint8List? image;

  _BlueprintPageViewModel(this.blueprint)
      : indexOfImages = 0,
        countOfImages = blueprint.images.length,
        image = blueprint.images.firstOrNull;

  bool isPreviousImageAvailable() {
    return indexOfImages > 0;
  }

  bool isNextImageAvailable() {
    return indexOfImages < countOfImages - 1;
  }

  void previousImage() {
    if (isPreviousImageAvailable()) {
      indexOfImages--;
      image = blueprint.images[indexOfImages];
      notifyListeners();
    }
  }

  void nextImage() {
    if (isNextImageAvailable()) {
      indexOfImages++;
      image = blueprint.images[indexOfImages];
      notifyListeners();
    }
  }

  Future<void> requestDelete(BuildContext context) async {
    await Dialog.showDialog(
      context,
      title: Text(blueprint.name),
      body: const Text('确定删除图纸吗？'),
      actions: [
        Button(
          body: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Button(
          body: const Text('确定'),
          theme: ButtonThemeData(
            color: material.Colors.red,
            hoverColor: material.Colors.red[600],
          ),
          onPressed: () async {
            final homeViewModel = context.read<HomeViewModel>();
            Navigator.of(context).pop();
            homeViewModel.updateHomeDetailPageKind(HomeDetailPageKind.start);
            realm.write(() {
              realm.deleteMany(blueprint.parts);
              realm.delete(blueprint);
            });
          },
        ),
      ],
    );
  }
}
