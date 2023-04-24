// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesModalAdapter extends TypeAdapter<NotesModal> {
  @override
  final int typeId = 0;

  @override
  NotesModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesModal(
      cardnumber: fields[0] as String,
      expiry: fields[1] as String,
      cardholder: fields[2] as String,
      cvv: fields[3] as String,
      bankname: fields[4] as String,
      color: fields[5] as int,

    );
  }

  @override
  void write(BinaryWriter writer, NotesModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardnumber)
      ..writeByte(1)
      ..write(obj.expiry)
      ..writeByte(2)
      ..write(obj.cardholder)
      ..writeByte(3)
      ..write(obj.cvv)
      ..writeByte(4)
      ..write(obj.bankname)
      ..writeByte(5)
      ..write(obj.color);

  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SocialModalAdapter extends TypeAdapter<SocialModal> {
  @override
  final int typeId = 1;

  @override
  SocialModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialModal(
      username: fields[0] as String,
      password: fields[1] as String,
      title: fields[2] as String,

    );
  }

  @override
  void write(BinaryWriter writer, SocialModal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.title);

  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryModalAdapter extends TypeAdapter<CategoryModal> {
  @override
  final int typeId = 2;

  @override
  CategoryModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModal(
      category: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}



