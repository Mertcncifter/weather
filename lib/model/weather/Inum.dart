import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Inum.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class Imum {
  Imum({
    this.value,
    this.unit,
    this.unitType,
  });
  @JsonKey(name: 'Value')
  @HiveField(0)
  double? value;
  @JsonKey(name: 'Unit')
  @HiveField(1)
  String? unit;
  @JsonKey(name: 'UnitType')
  @HiveField(2)
  int? unitType;

  factory Imum.fromJson(Map<String, dynamic> json) => _$ImumFromJson(json);
}
