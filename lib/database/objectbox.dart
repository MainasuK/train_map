import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:train_map/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    if (Platform.isMacOS) {
      final store =
          await openStore(macosApplicationGroup: 'A8K92XFF77.TrainMap');
      return ObjectBox._create(store);
    } else {
      final docsDir = await getApplicationDocumentsDirectory();
      final store =
          await openStore(directory: p.join(docsDir.path, "obx-example"));
      return ObjectBox._create(store);
    }
  }
}
