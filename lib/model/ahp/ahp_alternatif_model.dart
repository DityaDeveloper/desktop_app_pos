import 'package:freezed_annotation/freezed_annotation.dart';

part 'ahp_alternatif_model.freezed.dart';
part 'ahp_alternatif_model.g.dart';

@freezed
class AhpAlternatifModel with _$AhpAlternatifModel {
  //const HomeMenuModel._();
  const factory AhpAlternatifModel(
      {
      required String id,
      required String kode,
      required String namaAlternatif}) = _AhpAlternatifModel;

  factory AhpAlternatifModel.fromJson(Map<String, dynamic> json) =>
      _$AhpAlternatifModelFromJson(json);
}
