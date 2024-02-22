// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class listItemsAdapter extends TypeAdapter<listItems> {
  @override
  final int typeId = 1;

  @override
  listItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return listItems(
      name: fields[1] as String,
      age: fields[2] as String,
    )..id = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, listItems obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is listItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
