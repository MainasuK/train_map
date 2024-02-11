import 'dart:typed_data';

import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _Catalog {
  /// 图册名称
  @PrimaryKey()
  late String name;

  /// 图纸
  /// one-to-many
  late List<_Blueprint> blueprints;
}

@RealmModel()
class _Blueprint {
  @PrimaryKey()
  late final ObjectId id;

  /// 总成编号
  late String index;

  /// 备件图号
  late String code;

  /// 名称
  late String name;

  /// 备注
  late String remark;

  /// 图纸
  late List<Uint8List> images;

  late List<_Part> parts;

  @Backlink(#blueprints)
  late Iterable<_Catalog> catalog;
}

extension BlueprintExtension on Blueprint {
  static List<String> tableHeaderNames = [
    '总成编号',
    '备件图号',
    '名称',
    '备注',
  ];
}

@RealmModel()
class _Part {
  @PrimaryKey()
  late final ObjectId id;

  /// 代号
  late String index;

  /// 物资编码
  late String code;

  /// 零件名称
  late String name;

  /// 进口零件号
  late String importCode;

  /// 国产零件号
  late String domesticCode;

  /// 本总成数量
  late String count;

  /// 备注
  late String remark;

  @Backlink(#parts)
  late Iterable<_Blueprint> blueprint;
}

extension PartExtension on Part {
  static List<String> tableHeaderNames = [
    '代号',
    '物资编码',
    '零件名称',
    '进口零件号',
    '国产零件号',
    '本总成数量',
    '备注',
  ];
}
