import 'package:json_annotation/json_annotation.dart';

part 'address_entity.g.dart';

@JsonSerializable()
class AddressEntity {
  AddressEntity({
    required this.nik,
    required this.address,
    required this.province,
    required this.city,
    required this.subdistrict,
    required this.ward,
    required this.postalCode,
    required this.currentAddress,
    required this.currentProvince,
    required this.currentCity,
    required this.currentSubdistrict,
    required this.currentWard,
    required this.currentPostalCode,
  });

  int nik;
  String address;
  String province;
  String city;
  String subdistrict;
  String ward;
  int postalCode;
  String currentAddress;
  String currentProvince;
  String currentCity;
  String currentSubdistrict;
  String currentWard;
  int currentPostalCode;

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);

  factory AddressEntity.dummy() => AddressEntity(
        nik: 3507221234560001,
        address: 'Anonymous street 45',
        province: 'East Java',
        city: 'Malang',
        subdistrict: 'Dau',
        ward: 'Landungsari',
        postalCode: 65151,
        currentAddress: 'Anonymous street 45',
        currentProvince: 'East Java',
        currentCity: 'Malang',
        currentSubdistrict: 'Dau',
        currentWard: 'Landungsari',
        currentPostalCode: 65151,
      );

  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);
}
