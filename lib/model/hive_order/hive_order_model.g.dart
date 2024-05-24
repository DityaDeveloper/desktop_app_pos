// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOrderModelAdapter extends TypeAdapter<HiveOrderModel> {
  @override
  final int typeId = 0;

  @override
  HiveOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOrderModel(
      id: fields[0] as int,
      name: fields[1] as String,
      qty: fields[2] as int,
      unit: fields[3] as String,
      price: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOrderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.qty)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
