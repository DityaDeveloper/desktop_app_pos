// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ahp_alternatif_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AhpAlternatifModel _$AhpAlternatifModelFromJson(Map<String, dynamic> json) {
  return _AhpAlternatifModel.fromJson(json);
}

/// @nodoc
mixin _$AhpAlternatifModel {
  String get id => throw _privateConstructorUsedError;
  String get kode => throw _privateConstructorUsedError;
  String get namaAlternatif => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AhpAlternatifModelCopyWith<AhpAlternatifModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AhpAlternatifModelCopyWith<$Res> {
  factory $AhpAlternatifModelCopyWith(
          AhpAlternatifModel value, $Res Function(AhpAlternatifModel) then) =
      _$AhpAlternatifModelCopyWithImpl<$Res, AhpAlternatifModel>;
  @useResult
  $Res call({String id, String kode, String namaAlternatif});
}

/// @nodoc
class _$AhpAlternatifModelCopyWithImpl<$Res, $Val extends AhpAlternatifModel>
    implements $AhpAlternatifModelCopyWith<$Res> {
  _$AhpAlternatifModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? kode = null,
    Object? namaAlternatif = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      kode: null == kode
          ? _value.kode
          : kode // ignore: cast_nullable_to_non_nullable
              as String,
      namaAlternatif: null == namaAlternatif
          ? _value.namaAlternatif
          : namaAlternatif // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AhpAlternatifModelCopyWith<$Res>
    implements $AhpAlternatifModelCopyWith<$Res> {
  factory _$$_AhpAlternatifModelCopyWith(_$_AhpAlternatifModel value,
          $Res Function(_$_AhpAlternatifModel) then) =
      __$$_AhpAlternatifModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String kode, String namaAlternatif});
}

/// @nodoc
class __$$_AhpAlternatifModelCopyWithImpl<$Res>
    extends _$AhpAlternatifModelCopyWithImpl<$Res, _$_AhpAlternatifModel>
    implements _$$_AhpAlternatifModelCopyWith<$Res> {
  __$$_AhpAlternatifModelCopyWithImpl(
      _$_AhpAlternatifModel _value, $Res Function(_$_AhpAlternatifModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? kode = null,
    Object? namaAlternatif = null,
  }) {
    return _then(_$_AhpAlternatifModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      kode: null == kode
          ? _value.kode
          : kode // ignore: cast_nullable_to_non_nullable
              as String,
      namaAlternatif: null == namaAlternatif
          ? _value.namaAlternatif
          : namaAlternatif // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AhpAlternatifModel implements _AhpAlternatifModel {
  const _$_AhpAlternatifModel(
      {required this.id, required this.kode, required this.namaAlternatif});

  factory _$_AhpAlternatifModel.fromJson(Map<String, dynamic> json) =>
      _$$_AhpAlternatifModelFromJson(json);

  @override
  final String id;
  @override
  final String kode;
  @override
  final String namaAlternatif;

  @override
  String toString() {
    return 'AhpAlternatifModel(id: $id, kode: $kode, namaAlternatif: $namaAlternatif)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AhpAlternatifModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.kode, kode) || other.kode == kode) &&
            (identical(other.namaAlternatif, namaAlternatif) ||
                other.namaAlternatif == namaAlternatif));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, kode, namaAlternatif);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AhpAlternatifModelCopyWith<_$_AhpAlternatifModel> get copyWith =>
      __$$_AhpAlternatifModelCopyWithImpl<_$_AhpAlternatifModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AhpAlternatifModelToJson(
      this,
    );
  }
}

abstract class _AhpAlternatifModel implements AhpAlternatifModel {
  const factory _AhpAlternatifModel(
      {required final String id,
      required final String kode,
      required final String namaAlternatif}) = _$_AhpAlternatifModel;

  factory _AhpAlternatifModel.fromJson(Map<String, dynamic> json) =
      _$_AhpAlternatifModel.fromJson;

  @override
  String get id;
  @override
  String get kode;
  @override
  String get namaAlternatif;
  @override
  @JsonKey(ignore: true)
  _$$_AhpAlternatifModelCopyWith<_$_AhpAlternatifModel> get copyWith =>
      throw _privateConstructorUsedError;
}
