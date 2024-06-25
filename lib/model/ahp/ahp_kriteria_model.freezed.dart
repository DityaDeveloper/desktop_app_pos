// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ahp_kriteria_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AhpKriteriaModel _$AhpKriteriaModelFromJson(Map<String, dynamic> json) {
  return _AhpKriteriaModel.fromJson(json);
}

/// @nodoc
mixin _$AhpKriteriaModel {
  String get id => throw _privateConstructorUsedError;
  String get kode => throw _privateConstructorUsedError;
  String get namaKriteria => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AhpKriteriaModelCopyWith<AhpKriteriaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AhpKriteriaModelCopyWith<$Res> {
  factory $AhpKriteriaModelCopyWith(
          AhpKriteriaModel value, $Res Function(AhpKriteriaModel) then) =
      _$AhpKriteriaModelCopyWithImpl<$Res, AhpKriteriaModel>;
  @useResult
  $Res call({String id, String kode, String namaKriteria});
}

/// @nodoc
class _$AhpKriteriaModelCopyWithImpl<$Res, $Val extends AhpKriteriaModel>
    implements $AhpKriteriaModelCopyWith<$Res> {
  _$AhpKriteriaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? kode = null,
    Object? namaKriteria = null,
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
      namaKriteria: null == namaKriteria
          ? _value.namaKriteria
          : namaKriteria // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AhpKriteriaModelCopyWith<$Res>
    implements $AhpKriteriaModelCopyWith<$Res> {
  factory _$$_AhpKriteriaModelCopyWith(
          _$_AhpKriteriaModel value, $Res Function(_$_AhpKriteriaModel) then) =
      __$$_AhpKriteriaModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String kode, String namaKriteria});
}

/// @nodoc
class __$$_AhpKriteriaModelCopyWithImpl<$Res>
    extends _$AhpKriteriaModelCopyWithImpl<$Res, _$_AhpKriteriaModel>
    implements _$$_AhpKriteriaModelCopyWith<$Res> {
  __$$_AhpKriteriaModelCopyWithImpl(
      _$_AhpKriteriaModel _value, $Res Function(_$_AhpKriteriaModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? kode = null,
    Object? namaKriteria = null,
  }) {
    return _then(_$_AhpKriteriaModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      kode: null == kode
          ? _value.kode
          : kode // ignore: cast_nullable_to_non_nullable
              as String,
      namaKriteria: null == namaKriteria
          ? _value.namaKriteria
          : namaKriteria // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AhpKriteriaModel implements _AhpKriteriaModel {
  const _$_AhpKriteriaModel(
      {required this.id, required this.kode, required this.namaKriteria});

  factory _$_AhpKriteriaModel.fromJson(Map<String, dynamic> json) =>
      _$$_AhpKriteriaModelFromJson(json);

  @override
  final String id;
  @override
  final String kode;
  @override
  final String namaKriteria;

  @override
  String toString() {
    return 'AhpKriteriaModel(id: $id, kode: $kode, namaKriteria: $namaKriteria)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AhpKriteriaModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.kode, kode) || other.kode == kode) &&
            (identical(other.namaKriteria, namaKriteria) ||
                other.namaKriteria == namaKriteria));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, kode, namaKriteria);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AhpKriteriaModelCopyWith<_$_AhpKriteriaModel> get copyWith =>
      __$$_AhpKriteriaModelCopyWithImpl<_$_AhpKriteriaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AhpKriteriaModelToJson(
      this,
    );
  }
}

abstract class _AhpKriteriaModel implements AhpKriteriaModel {
  const factory _AhpKriteriaModel(
      {required final String id,
      required final String kode,
      required final String namaKriteria}) = _$_AhpKriteriaModel;

  factory _AhpKriteriaModel.fromJson(Map<String, dynamic> json) =
      _$_AhpKriteriaModel.fromJson;

  @override
  String get id;
  @override
  String get kode;
  @override
  String get namaKriteria;
  @override
  @JsonKey(ignore: true)
  _$$_AhpKriteriaModelCopyWith<_$_AhpKriteriaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
