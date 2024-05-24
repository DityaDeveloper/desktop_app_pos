// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      ref: json['ref'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      qty: json['qty'] as int,
      unit: json['unit'] as String,
      price: json['price'] as int,
      createdAt: json['createdAt'] as String? ?? '',
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'id': instance.id,
      'name': instance.name,
      'qty': instance.qty,
      'unit': instance.unit,
      'price': instance.price,
      'createdAt': instance.createdAt,
    };
