import 'package:freezed_annotation/freezed_annotation.dart';

part 'static_model.freezed.dart';
part 'static_model.g.dart';

@freezed
class StaticModel with _$StaticModel {
  //const HomeMenuModel._();
  const factory StaticModel({
    required String ref,
    required String id,
    required String name,
    required int qty,
    required String unit,
    required int price
  }) = _StaticModel;

   factory StaticModel.fromJson(Map<String, dynamic> json) =>
      _$StaticModelFromJson(json);

}
