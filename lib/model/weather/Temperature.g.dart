// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Temperature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemperatureAdapter extends TypeAdapter<Temperature> {
  @override
  final int typeId = 3;

  @override
  Temperature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Temperature(
      minimum: fields[0] as Imum?,
      maximum: fields[1] as Imum?,
    );
  }

  @override
  void write(BinaryWriter writer, Temperature obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.minimum)
      ..writeByte(1)
      ..write(obj.maximum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      minimum: json['Minimum'] == null
          ? null
          : Imum.fromJson(json['Minimum'] as Map<String, dynamic>),
      maximum: json['Maximum'] == null
          ? null
          : Imum.fromJson(json['Maximum'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'Minimum': instance.minimum,
      'Maximum': instance.maximum,
    };
