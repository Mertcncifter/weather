import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Day.dart';
import 'Temperature.dart';

part 'DailyForecasts.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class DailyForecasts {
  DailyForecasts({
    this.date,
    this.epochDate,
    this.temperature,
    this.day,
    this.night,
  });
  @JsonKey(name: 'Date')
  @HiveField(0)
  DateTime? date;
  @JsonKey(name: 'EpochDate')
  @HiveField(1)
  int? epochDate;
  @JsonKey(name: 'Temperature')
  @HiveField(2)
  Temperature? temperature;
  @JsonKey(name: 'Day')
  @HiveField(3)
  Day? day;
  @JsonKey(name: 'Night')
  @HiveField(4)
  Day? night;

  factory DailyForecasts.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastsFromJson(json);
}
