import 'package:hive/hive.dart';
part 'listModel.g.dart';

@HiveType(typeId: 1)
class listItems{
  @HiveField(0)
  int?id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  listItems({required this.name, required this.age , this.id});
}

