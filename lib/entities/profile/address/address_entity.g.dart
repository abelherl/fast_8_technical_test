// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressEntity _$AddressEntityFromJson(Map<String, dynamic> json) =>
    AddressEntity(
      nik: (json['nik'] as num).toInt(),
      address: json['address'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      subdistrict: json['subdistrict'] as String,
      ward: json['ward'] as String,
      postalCode: (json['postalCode'] as num).toInt(),
      currentAddress: json['currentAddress'] as String,
      currentProvince: json['currentProvince'] as String,
      currentCity: json['currentCity'] as String,
      currentSubdistrict: json['currentSubdistrict'] as String,
      currentWard: json['currentWard'] as String,
      currentPostalCode: (json['currentPostalCode'] as num).toInt(),
    );

Map<String, dynamic> _$AddressEntityToJson(AddressEntity instance) =>
    <String, dynamic>{
      'nik': instance.nik,
      'address': instance.address,
      'province': instance.province,
      'city': instance.city,
      'subdistrict': instance.subdistrict,
      'ward': instance.ward,
      'postalCode': instance.postalCode,
      'currentAddress': instance.currentAddress,
      'currentProvince': instance.currentProvince,
      'currentCity': instance.currentCity,
      'currentSubdistrict': instance.currentSubdistrict,
      'currentWard': instance.currentWard,
      'currentPostalCode': instance.currentPostalCode,
    };
