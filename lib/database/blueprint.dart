import 'package:objectbox/objectbox.dart';

@Entity()
class Blueprint {
  @Id()
  int id;
  String index;
  String code;
  String name;
  String remark;

  Blueprint({
    this.id = 0,
    required this.index,
    required this.code,
    required this.name,
    required this.remark,
  });
}
