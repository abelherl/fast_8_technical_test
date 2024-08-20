// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biodata_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiodataEntity _$BiodataEntityFromJson(Map<String, dynamic> json) =>
    BiodataEntity(
      fullName: json['fullName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      gender: json['gender'] as String,
      email: json['email'] as String,
      phoneNumber: (json['phoneNumber'] as num).toInt(),
      educationLevel: json['educationLevel'] as String,
      marriageStatus: json['marriageStatus'] as String,
    );

Map<String, dynamic> _$BiodataEntityToJson(BiodataEntity instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'birthDate': instance.birthDate.toIso8601String(),
      'gender': instance.gender,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'educationLevel': instance.educationLevel,
      'marriageStatus': instance.marriageStatus,
    };
