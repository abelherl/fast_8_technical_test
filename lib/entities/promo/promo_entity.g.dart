// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromoEntityAdapter extends TypeAdapter<PromoEntity> {
  @override
  final int typeId = 1;

  @override
  PromoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PromoEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      discountPercentage: fields[4] as double,
      discountedPrice: fields[5] as double,
      imageUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PromoEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.discountPercentage)
      ..writeByte(5)
      ..write(obj.discountedPrice)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
