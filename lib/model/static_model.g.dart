// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StaticModel _$$_StaticModelFromJson(Map<String, dynamic> json) =>
    _$_StaticModel(
      ref: json['ref'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      qty: json['qty'] as int,
      unit: json['unit'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$$_StaticModelToJson(_$_StaticModel instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'id': instance.id,
      'name': instance.name,
      'qty': instance.qty,
      'unit': instance.unit,
      'price': instance.price,
    };
