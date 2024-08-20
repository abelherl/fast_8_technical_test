// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) =>
    ProfileEntity(
      id: (json['id'] as num).toInt(),
      biodata: BiodataEntity.fromJson(json['biodata'] as Map<String, dynamic>),
      address: AddressEntity.fromJson(json['address'] as Map<String, dynamic>),
      company: CompanyEntity.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileEntityToJson(ProfileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'biodata': instance.biodata,
      'address': instance.address,
      'company': instance.company,
    };
