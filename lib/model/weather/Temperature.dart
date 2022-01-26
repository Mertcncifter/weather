import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/weather/Inum.dart';

part 'Temperature.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Temperature {
  Temperature({
    this.minimum,
    this.maximum,
  });
  @JsonKey(name: 'Minimum')
  @HiveField(0)
  Imum? minimum;
  @HiveField(1)
  @JsonKey(name: 'Maximum')
  Imum? maximum;

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
}
