// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 5;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      icon: fields[0] as int?,
      iconPhrase: fields[1] as String?,
      hasPrecipitation: fields[2] as bool?,
      precipitationType: fields[3] as String?,
      precipitationIntensity: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.icon)
      ..writeByte(1)
      ..write(obj.iconPhrase)
      ..writeByte(2)
      ..write(obj.hasPrecipitation)
      ..writeByte(3)
      ..write(obj.precipitationType)
      ..writeByte(4)
      ..write(obj.precipitationIntensity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      icon: json['Icon'] as int?,
      iconPhrase: json['IconPhrase'] as String?,
      hasPrecipitation: json['HasPrecipitation'] as bool?,
      precipitationType: json['PrecipitationType'] as String?,
      precipitationIntensity: json['PrecipitationIntensity'] as String?,
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'Icon': instance.icon,
      'IconPhrase': instance.iconPhrase,
      'HasPrecipitation': instance.hasPrecipitation,
      'PrecipitationType': instance.precipitationType,
      'PrecipitationIntensity': instance.precipitationIntensity,
    };
