import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Day.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Day {
  Day({
    this.icon,
    this.iconPhrase,
    this.hasPrecipitation,
    this.precipitationType,
    this.precipitationIntensity,
  });
  @JsonKey(name: 'Icon')
  @HiveField(0)
  int? icon;
  @JsonKey(name: 'IconPhrase')
  @HiveField(1)
  String? iconPhrase;
  @JsonKey(name: 'HasPrecipitation')
  @HiveField(2)
  bool? hasPrecipitation;
  @JsonKey(name: 'PrecipitationType')
  @HiveField(3)
  String? precipitationType;
  @JsonKey(name: 'PrecipitationIntensity')
  @HiveField(4)
  String? precipitationIntensity;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
}
