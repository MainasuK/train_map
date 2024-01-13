import 'package:objectbox/objectbox.dart';

@Entity()
class Part {
  @Id()
  int id;
  String index;
  String code;
  String name;
  String importCode;
  String domesticCode;
  String count;
  String remark;

  Part({
    this.id = 0,
    required this.index,
    required this.code,
    required this.name,
    required this.importCode,
    required this.domesticCode,
    required this.count,
    required this.remark,
  });
}
