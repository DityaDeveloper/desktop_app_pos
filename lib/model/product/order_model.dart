import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  //const HomeMenuModel._();
  const factory OrderModel({
    required String ref,
    required String id,
    required String name,
    required int qty,
    required String unit,
    required int price,
    @Default('') String createdAt,
  }) = _OrderModel;

   factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

}
