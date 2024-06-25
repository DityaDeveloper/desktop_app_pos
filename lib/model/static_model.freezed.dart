// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'static_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StaticModel _$StaticModelFromJson(Map<String, dynamic> json) {
  return _StaticModel.fromJson(json);
}

/// @nodoc
mixin _$StaticModel {
  String get ref => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get qty => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaticModelCopyWith<StaticModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaticModelCopyWith<$Res> {
  factory $StaticModelCopyWith(
          StaticModel value, $Res Function(StaticModel) then) =
      _$StaticModelCopyWithImpl<$Res, StaticModel>;
  @useResult
  $Res call(
      {String ref,
      String id,
      String name,
      int qty,
      String unit,
      int price,
      String image});
}

/// @nodoc
class _$StaticModelCopyWithImpl<$Res, $Val extends StaticModel>
    implements $StaticModelCopyWith<$Res> {
  _$StaticModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? id = null,
    Object? name = null,
    Object? qty = null,
    Object? unit = null,
    Object? price = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StaticModelCopyWith<$Res>
    implements $StaticModelCopyWith<$Res> {
  factory _$$_StaticModelCopyWith(
          _$_StaticModel value, $Res Function(_$_StaticModel) then) =
      __$$_StaticModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ref,
      String id,
      String name,
      int qty,
      String unit,
      int price,
      String image});
}

/// @nodoc
class __$$_StaticModelCopyWithImpl<$Res>
    extends _$StaticModelCopyWithImpl<$Res, _$_StaticModel>
    implements _$$_StaticModelCopyWith<$Res> {
  __$$_StaticModelCopyWithImpl(
      _$_StaticModel _value, $Res Function(_$_StaticModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? id = null,
    Object? name = null,
    Object? qty = null,
    Object? unit = null,
    Object? price = null,
    Object? image = null,
  }) {
    return _then(_$_StaticModel(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StaticModel implements _StaticModel {
  const _$_StaticModel(
      {required this.ref,
      required this.id,
      required this.name,
      required this.qty,
      required this.unit,
      required this.price,
      this.image = ''});

  factory _$_StaticModel.fromJson(Map<String, dynamic> json) =>
      _$$_StaticModelFromJson(json);

  @override
  final String ref;
  @override
  final String id;
  @override
  final String name;
  @override
  final int qty;
  @override
  final String unit;
  @override
  final int price;
  @override
  @JsonKey()
  final String image;

  @override
  String toString() {
    return 'StaticModel(ref: $ref, id: $id, name: $name, qty: $qty, unit: $unit, price: $price, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StaticModel &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ref, id, name, qty, unit, price, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StaticModelCopyWith<_$_StaticModel> get copyWith =>
      __$$_StaticModelCopyWithImpl<_$_StaticModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StaticModelToJson(
      this,
    );
  }
}

abstract class _StaticModel implements StaticModel {
  const factory _StaticModel(
      {required final String ref,
      required final String id,
      required final String name,
      required final int qty,
      required final String unit,
      required final int price,
      final String image}) = _$_StaticModel;

  factory _StaticModel.fromJson(Map<String, dynamic> json) =
      _$_StaticModel.fromJson;

  @override
  String get ref;
  @override
  String get id;
  @override
  String get name;
  @override
  int get qty;
  @override
  String get unit;
  @override
  int get price;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_StaticModelCopyWith<_$_StaticModel> get copyWith =>
      throw _privateConstructorUsedError;
}
