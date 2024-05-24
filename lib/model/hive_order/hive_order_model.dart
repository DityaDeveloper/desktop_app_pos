import 'package:hive/hive.dart';

part 'hive_order_model.g.dart';

@HiveType(typeId: 0)
class HiveOrderModel{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int qty;
  @HiveField(3)
  final String unit;
  @HiveField(4)
  final int price;

  HiveOrderModel({required this.id, required this.name, required this.qty, required this.unit, required this.price});

}