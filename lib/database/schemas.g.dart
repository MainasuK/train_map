// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Catalog extends _Catalog with RealmEntity, RealmObjectBase, RealmObject {
  Catalog(
    String name, {
    Iterable<Blueprint> blueprints = const [],
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<Blueprint>>(
        this, 'blueprints', RealmList<Blueprint>(blueprints));
  }

  Catalog._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<Blueprint> get blueprints =>
      RealmObjectBase.get<Blueprint>(this, 'blueprints')
          as RealmList<Blueprint>;
  @override
  set blueprints(covariant RealmList<Blueprint> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Catalog>> get changes =>
      RealmObjectBase.getChanges<Catalog>(this);

  @override
  Catalog freeze() => RealmObjectBase.freezeObject<Catalog>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Catalog._);
    return const SchemaObject(ObjectType.realmObject, Catalog, 'Catalog', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('blueprints', RealmPropertyType.object,
          linkTarget: 'Blueprint', collectionType: RealmCollectionType.list),
    ]);
  }
}

class Blueprint extends _Blueprint
    with RealmEntity, RealmObjectBase, RealmObject {
  Blueprint(
    ObjectId id,
    String index,
    String code,
    String name,
    String remark, {
    Iterable<Uint8List> images = const [],
    Iterable<Part> parts = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'remark', remark);
    RealmObjectBase.set<RealmList<Uint8List>>(
        this, 'images', RealmList<Uint8List>(images));
    RealmObjectBase.set<RealmList<Part>>(this, 'parts', RealmList<Part>(parts));
  }

  Blueprint._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get index => RealmObjectBase.get<String>(this, 'index') as String;
  @override
  set index(String value) => RealmObjectBase.set(this, 'index', value);

  @override
  String get code => RealmObjectBase.get<String>(this, 'code') as String;
  @override
  set code(String value) => RealmObjectBase.set(this, 'code', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get remark => RealmObjectBase.get<String>(this, 'remark') as String;
  @override
  set remark(String value) => RealmObjectBase.set(this, 'remark', value);

  @override
  RealmList<Uint8List> get images =>
      RealmObjectBase.get<Uint8List>(this, 'images') as RealmList<Uint8List>;
  @override
  set images(covariant RealmList<Uint8List> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Part> get parts =>
      RealmObjectBase.get<Part>(this, 'parts') as RealmList<Part>;
  @override
  set parts(covariant RealmList<Part> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<Catalog> get catalog {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<Catalog>(this, 'catalog')
        as RealmResults<Catalog>;
  }

  @override
  set catalog(covariant RealmResults<Catalog> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Blueprint>> get changes =>
      RealmObjectBase.getChanges<Blueprint>(this);

  @override
  Blueprint freeze() => RealmObjectBase.freezeObject<Blueprint>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Blueprint._);
    return const SchemaObject(ObjectType.realmObject, Blueprint, 'Blueprint', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('index', RealmPropertyType.string),
      SchemaProperty('code', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('remark', RealmPropertyType.string),
      SchemaProperty('images', RealmPropertyType.binary,
          collectionType: RealmCollectionType.list),
      SchemaProperty('parts', RealmPropertyType.object,
          linkTarget: 'Part', collectionType: RealmCollectionType.list),
      SchemaProperty('catalog', RealmPropertyType.linkingObjects,
          linkOriginProperty: 'blueprints',
          collectionType: RealmCollectionType.list,
          linkTarget: 'Catalog'),
    ]);
  }
}

class Part extends _Part with RealmEntity, RealmObjectBase, RealmObject {
  Part(
    ObjectId id,
    String index,
    String code,
    String name,
    String importCode,
    String domesticCode,
    String count,
    String remark,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'importCode', importCode);
    RealmObjectBase.set(this, 'domesticCode', domesticCode);
    RealmObjectBase.set(this, 'count', count);
    RealmObjectBase.set(this, 'remark', remark);
  }

  Part._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get index => RealmObjectBase.get<String>(this, 'index') as String;
  @override
  set index(String value) => RealmObjectBase.set(this, 'index', value);

  @override
  String get code => RealmObjectBase.get<String>(this, 'code') as String;
  @override
  set code(String value) => RealmObjectBase.set(this, 'code', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get importCode =>
      RealmObjectBase.get<String>(this, 'importCode') as String;
  @override
  set importCode(String value) =>
      RealmObjectBase.set(this, 'importCode', value);

  @override
  String get domesticCode =>
      RealmObjectBase.get<String>(this, 'domesticCode') as String;
  @override
  set domesticCode(String value) =>
      RealmObjectBase.set(this, 'domesticCode', value);

  @override
  String get count => RealmObjectBase.get<String>(this, 'count') as String;
  @override
  set count(String value) => RealmObjectBase.set(this, 'count', value);

  @override
  String get remark => RealmObjectBase.get<String>(this, 'remark') as String;
  @override
  set remark(String value) => RealmObjectBase.set(this, 'remark', value);

  @override
  RealmResults<Blueprint> get blueprint {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<Blueprint>(this, 'blueprint')
        as RealmResults<Blueprint>;
  }

  @override
  set blueprint(covariant RealmResults<Blueprint> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Part>> get changes =>
      RealmObjectBase.getChanges<Part>(this);

  @override
  Part freeze() => RealmObjectBase.freezeObject<Part>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Part._);
    return const SchemaObject(ObjectType.realmObject, Part, 'Part', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('index', RealmPropertyType.string),
      SchemaProperty('code', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('importCode', RealmPropertyType.string),
      SchemaProperty('domesticCode', RealmPropertyType.string),
      SchemaProperty('count', RealmPropertyType.string),
      SchemaProperty('remark', RealmPropertyType.string),
      SchemaProperty('blueprint', RealmPropertyType.linkingObjects,
          linkOriginProperty: 'parts',
          collectionType: RealmCollectionType.list,
          linkTarget: 'Blueprint'),
    ]);
  }
}
