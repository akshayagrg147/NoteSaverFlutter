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
      color: fields[5] as int?,
      cardtype: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotesModal obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.cardtype);
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
      title: fields[2] as String?,
      icon: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SocialModal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.icon);
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

class ProfileInfoModelAdapter extends TypeAdapter<ProfileInfoModal> {
  @override
  final int typeId = 2;

  @override
  ProfileInfoModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileInfoModal(
      firstname: fields[0] as String,
      lastname: fields[1] as String,
      email: fields[2] as String,
      gender: fields[3] as String,
      image: fields[4] as File?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileInfoModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstname)
      ..writeByte(1)
      ..write(obj.lastname)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DocumentModalAdapter extends TypeAdapter<DocumentModal> {
  @override
  final int typeId = 3;

  @override
  DocumentModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocumentModal(
      name: fields[0] as String?,
      // doc: fields[1] as File?,
    );
  }

  @override
  void write(BinaryWriter writer, DocumentModal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name)
      // ..writeByte(1)
      // ..write(obj.doc)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DocumentModalAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
