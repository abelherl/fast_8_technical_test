// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyEntity _$CompanyEntityFromJson(Map<String, dynamic> json) =>
    CompanyEntity(
      name: json['name'] as String,
      address: json['address'] as String,
      position: json['position'] as String,
      tenure: json['tenure'] as String,
      incomeType: json['incomeType'] as String,
      yearlyGross: json['yearlyGross'] as String,
      bankName: json['bankName'] as String,
      bankAccountName: json['bankAccountName'] as String,
      bankAccountNumber: (json['bankAccountNumber'] as num).toInt(),
    );

Map<String, dynamic> _$CompanyEntityToJson(CompanyEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'position': instance.position,
      'tenure': instance.tenure,
      'incomeType': instance.incomeType,
      'yearlyGross': instance.yearlyGross,
      'bankName': instance.bankName,
      'bankAccountNumber': instance.bankAccountNumber,
      'bankAccountName': instance.bankAccountName,
    };
