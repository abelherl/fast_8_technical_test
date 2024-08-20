import 'package:payuung/entities/profile/address/address_entity.dart';
import 'package:payuung/entities/profile/biodata/biodata_entity.dart';
import 'package:payuung/entities/profile/company/company_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  ProfileEntity({
    required this.id,
    required this.biodata,
    required this.address,
    required this.company,
  });

  final int id;
  BiodataEntity biodata;
  AddressEntity address;
  CompanyEntity company;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);

  factory ProfileEntity.dummy() => ProfileEntity(
    id: 0,
    biodata: BiodataEntity.dummy(),
    address: AddressEntity.dummy(),
    company: CompanyEntity.dummy(),
  );

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);
}
