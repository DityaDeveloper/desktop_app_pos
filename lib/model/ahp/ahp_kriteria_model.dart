import 'package:freezed_annotation/freezed_annotation.dart';

part 'ahp_kriteria_model.freezed.dart';
part 'ahp_kriteria_model.g.dart';

@freezed
class AhpKriteriaModel with _$AhpKriteriaModel {
  //const HomeMenuModel._();
  const factory AhpKriteriaModel({
    required String id,
    required String kode,
    required String namaKriteria
  }) = _AhpKriteriaModel;

   factory AhpKriteriaModel.fromJson(Map<String, dynamic> json) =>
      _$AhpKriteriaModelFromJson(json);

}
