// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Inum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImumAdapter extends TypeAdapter<Imum> {
  @override
  final int typeId = 4;

  @override
  Imum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Imum(
      value: fields[0] as double?,
      unit: fields[1] as String?,
      unitType: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Imum obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.unitType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Imum _$ImumFromJson(Map<String, dynamic> json) => Imum(
      value: (json['Value'] as num?)?.toDouble(),
      unit: json['Unit'] as String?,
      unitType: json['UnitType'] as int?,
    );

Map<String, dynamic> _$ImumToJson(Imum instance) => <String, dynamic>{
      'Value': instance.value,
      'Unit': instance.unit,
      'UnitType': instance.unitType,
    };
