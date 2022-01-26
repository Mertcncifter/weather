// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyForecasts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyForecastsAdapter extends TypeAdapter<DailyForecasts> {
  @override
  final int typeId = 2;

  @override
  DailyForecasts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyForecasts(
      date: fields[0] as DateTime?,
      epochDate: fields[1] as int?,
      temperature: fields[2] as Temperature?,
      day: fields[3] as Day?,
      night: fields[4] as Day?,
    );
  }

  @override
  void write(BinaryWriter writer, DailyForecasts obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.epochDate)
      ..writeByte(2)
      ..write(obj.temperature)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.night);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyForecastsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyForecasts _$DailyForecastsFromJson(Map<String, dynamic> json) =>
    DailyForecasts(
      date:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      epochDate: json['EpochDate'] as int?,
      temperature: json['Temperature'] == null
          ? null
          : Temperature.fromJson(json['Temperature'] as Map<String, dynamic>),
      day: json['Day'] == null
          ? null
          : Day.fromJson(json['Day'] as Map<String, dynamic>),
      night: json['Night'] == null
          ? null
          : Day.fromJson(json['Night'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyForecastsToJson(DailyForecasts instance) =>
    <String, dynamic>{
      'Date': instance.date?.toIso8601String(),
      'EpochDate': instance.epochDate,
      'Temperature': instance.temperature,
      'Day': instance.day,
      'Night': instance.night,
    };
